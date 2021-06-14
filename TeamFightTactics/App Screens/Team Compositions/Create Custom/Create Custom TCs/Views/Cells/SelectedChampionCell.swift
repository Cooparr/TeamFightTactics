//
//  CreateSelectedChampionCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 14/12/2020.
//  Copyright © 2020 Alexander James Cooper. All rights reserved.
//

import UIKit

class SelectedChampionCell: BaseTableViewCell, ReusableCell {
    
    //MARK:- Properties
    typealias DataType = Champion
    static var reuseId: String = "selectedChampionCellId"
    private let championNameLabel = BaseLabel(fontSize: 18, fontWeight: .regular, fontColor: ThemeColor.platinum)
    private let championImageView = ChampionImageView(frame: .zero)
    let itemsStackView = BaseStack(axis: .horizontal, distribution: .fillEqually, spacing: 5)
    
    var removeChampCallback: ((UITableViewCell)->())?
    lazy var removeChampButton: BaseButton = {
        let btn = BaseButton(btnImage: SFSymbol.OtherIcons.delete, tintColor: ThemeColor.romanSilver)
        btn.addTarget(self, action: #selector(removeChampPressed), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK: Override Set Selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? ThemeColor.Highlighted.charcoal : ThemeColor.charcoal
    }
    
    
    //MARK: Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        itemsStackView.arrangedSubviews.forEach {
            guard let itemView = $0 as? TappableItemView else { return }
            itemView.resetImageToNil()
        }
    }
    
    
    //MARK:- Configure Cell
    func configureCell(with champion: Champion) {
        championImageView.useStandardOrSetSkin(champion.imageURL, champion.name.formattedName())
        championImageView.setChampCostBorderColor(champCost: champion.cost)
        championNameLabel.text = champion.name
        
        guard let customItems = champion.customItems else { return }        
        for (index, itemName) in customItems.enumerated() {
            guard let itemView = itemsStackView.arrangedSubviews[index] as? TappableItemView else { return }
            itemView.setItem(itemName)
        }
    }
    
    
    //MARK: Create Tappable Item Views
    private func createTappableItemViews() {
        (0..<Champion.maxNumOfItemsCanHold).forEach { _ in
            let itemView = TappableItemView()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemViewTapAction(_:)))
            itemView.addGestureRecognizer(tapGesture)
            itemsStackView.addArrangedSubview(itemView)
        }
    }
    
    
    //MARK: Item View Tap Action
    @objc func itemViewTapAction(_ gesture: UITapGestureRecognizer) {
        guard let itemView = gesture.view as? TappableItemView, let itemName = itemView.itemName else { return }
        itemView.removeItemDelegate?.tappableItemView(removeItem: itemName, from: self)
        itemView.clearItem()
    }
    
    
    //MARK: Remove Champ Action
    @objc func removeChampPressed(_ sender : UIButton) {
        removeChampCallback?(self)
    }
    
    
    //MARK:- Setup Cell
    override func setupCell() {
        backgroundColor = ThemeColor.charcoal
        
        constrainChampionImageView()
        constrainChampionNameLabel()
        constrainRemoveChampButton()
        constrainItemsStackView()
        createTappableItemViews()
    }
    
    
    //MARK: Constrain Champion Image View
    fileprivate func constrainChampionImageView() {
        contentView.addSubview(championImageView)
        NSLayoutConstraint.activate([
            championImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            championImageView.heightAnchor.constraint(equalToConstant: 50),
            championImageView.widthAnchor.constraint(equalTo: championImageView.heightAnchor),
            championImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    //MARK: Constrain Champion Name Label
    fileprivate func constrainChampionNameLabel() {
        contentView.addSubview(championNameLabel)
        NSLayoutConstraint.activate([
            championNameLabel.topAnchor.constraint(equalTo: championImageView.topAnchor),
            championNameLabel.leadingAnchor.constraint(equalTo: championImageView.trailingAnchor, constant: 10),
            championNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            championNameLabel.bottomAnchor.constraint(equalTo: championImageView.bottomAnchor)
        ])
    }

    
    //MARK: Constrain Remove Champ Button
    private func constrainRemoveChampButton() {
        contentView.addSubview(removeChampButton)
        NSLayoutConstraint.activate([
            removeChampButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            removeChampButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            removeChampButton.heightAnchor.constraint(equalToConstant: 35),
            removeChampButton.widthAnchor.constraint(equalTo: removeChampButton.heightAnchor)
        ])
    }
    
    
    //MARK: Constrain Items Stack View
    fileprivate func constrainItemsStackView() {
        let stackViewSpacing: CGFloat = 5
        let stackHeight: CGFloat = 35
        
        contentView.addSubview(itemsStackView)
        NSLayoutConstraint.activate([
            itemsStackView.trailingAnchor.constraint(equalTo: removeChampButton.leadingAnchor, constant: -8),
            itemsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemsStackView.heightAnchor.constraint(equalToConstant: stackHeight),
            itemsStackView.widthAnchor.constraint(lessThanOrEqualToConstant: (stackHeight * CGFloat(Champion.maxNumOfItemsCanHold)) + (CGFloat(Champion.maxNumOfItemsCanHold) * stackViewSpacing))
        ]) 
    }
}
