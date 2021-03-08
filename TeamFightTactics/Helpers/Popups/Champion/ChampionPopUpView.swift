//
//  ChampionPopUpView.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 29/09/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class ChampionPopUpView: UIView {
    
    //MARK:- Properties
    let champion: Champion
    var centerYConstraint: NSLayoutConstraint?
    var containerOrigin: CGPoint!
    let popUpViewMainStack = BaseStack(axis: .vertical, spacing: 15)
    let champImageSection = PopUpChampImageSection(tamic: false)
    let champStatsSection = PopUpChampStatsSection(tamic: false)
    private let abilitySection: FullAbilityView
    
    let popUpView: BaseView = {
        let view = BaseView(backgroundColor: ThemeColor.charcoal, cornerRadius: 10)
        view.clipsToBounds = true
        return view
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: nil)
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.frame = UIScreen.main.bounds
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blur
    }()
    
    //MARK: Init
    init(champion: Champion) {
        self.champion = champion
        self.abilitySection = FullAbilityView(champAbility: champion.ability)
        
        super.init(frame: .zero)
        setupView()
        constrainBlurEffect()
        constrainPopUpView()
        constrainPopUpViewMainStack()
        abilitySection.configureAbilityView(champAbility: champion.ability)
        champImageSection.configureChampImageSection(champion: champion)
        champStatsSection.configureStatsSection(champStat: champion.stats)
    }
    
    
    //MARK:- Setup View
    func setupView() {
        containerOrigin = self.frame.origin
        translatesAutoresizingMaskIntoConstraints = false
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    
    //MARK:- Constrain Blur Effect
    fileprivate func constrainBlurEffect() {
        addSubview(blurEffectView)
        blurEffectView.pinSubview(to: self)
    }
    
    
    //MARK:- Constrain PopUpView
    fileprivate func constrainPopUpView() {
        addSubview(popUpView)
        NSLayoutConstraint.activate([
            popUpView.centerXAnchor.constraint(equalTo: centerXAnchor),
            popUpView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30),
        ])
        centerYConstraint = popUpView.centerYAnchor.constraint(equalTo: centerYAnchor)
        centerYConstraint?.isActive = true
    }
    
    
    //MARK:- Constrain PopUp View Stack
    fileprivate func constrainPopUpViewMainStack() {
        popUpView.addSubview(popUpViewMainStack)
        popUpViewMainStack.addArrangedSubviews(champImageSection, champStatsSection, abilitySection)
        NSLayoutConstraint.activate([
            popUpViewMainStack.topAnchor.constraint(equalTo: popUpView.topAnchor),
            popUpViewMainStack.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor),
            popUpViewMainStack.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor),
            popUpViewMainStack.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: -10)
        ])
    }
    
    
    //MARK:- Handle Dismiss
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        let duration: TimeInterval = 0.7
        let damping: CGFloat = 1
        let velocity: CGFloat = 1
        
        switch sender.state {
        case .changed:
            containerFollowUserSwipe(sender, duration, damping, velocity)
        case .ended:
            if containerOrigin.y < 150 {
                returnContainerToCenter(duration, damping, velocity)
            } else {
                fadeOutContainerAndRemove(duration, damping, velocity)
            }
        default:
            break
        }
    }
    
    
    //MARK:- Follow User Swipe
    fileprivate func containerFollowUserSwipe(_ sender: UIPanGestureRecognizer, _ duration: TimeInterval, _ damping: CGFloat, _ velocity: CGFloat) {
        containerOrigin = sender.translation(in: self.popUpView)
        if self.containerOrigin.y > 0 {
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: .curveEaseOut, animations: {
                self.popUpView.transform = CGAffineTransform(translationX: 0, y: self.containerOrigin.y)
            })
        }
    }
    
    
    //MARK:- Return Container to Center
    fileprivate func returnContainerToCenter(_ duration: TimeInterval, _ damping: CGFloat, _ velocity: CGFloat) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: .curveEaseOut, animations: {
            self.popUpView.transform = .identity
        })
    }
    
    
    //MARK:- Fade Out Container
    fileprivate func fadeOutContainerAndRemove(_ duration: TimeInterval, _ damping: CGFloat, _ velocity: CGFloat) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: .curveEaseOut) {
            self.popUpView.transform = CGAffineTransform(translationX: 0, y: self.frame.maxY)
            self.blurEffectView.effect = nil
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
