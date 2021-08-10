//
//  ErrorAlertVC.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/01/2021.
//  Copyright © 2021 Alexander James Cooper. All rights reserved.
//

import UIKit

class ErrorAlertVC: UIViewController {

    //MARK: Properties
    let containerView = ErrorAlertView()
    let titleLabel = BaseLabel(fontSize: 20, fontWeight: .bold, textAlignment: .center, multiLine: true)
    let messageLabel = BaseLabel(fontSize: 14, fontWeight: .regular, textAlignment: .center)
    let actionButton = ErrorAlertButton(backgroundColor: ThemeColor.romanSilver)
    
    var alertTitle: String?
    var alertMessage: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    
    //MARK: Custom Init
    init(title: String, message: String, buttonTitle: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.buttonTitle = buttonTitle
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureAlertButton()
        configureMessageLabel()
    }
    
    
    //MARK: Dismiss VC Action
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    
    //MARK: Configure Container View
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.addSubviews(titleLabel, actionButton, messageLabel)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
        ])
    }
    
    
    //MARK: Configure Title Label
    private func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    
    //MARK: Configure Alert Button
    private func configureAlertButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    //MARK: Configure Message Label
    private func configureMessageLabel() {
        messageLabel.text = alertMessage ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -16)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
