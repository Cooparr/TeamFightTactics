//
//  TeamCompCell.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 17/10/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import SDWebImage

class TeamCompCell: UITableViewCell {

    var teamComp: TeamComposition? {
        didSet {
            guard
                let title = teamComp?.title,
                let tier = teamComp?.tier,
                let endGameChamps = teamComp?.endGame,
                let synergies = teamComp?.synergies
                else { return }
            
            
            
            synergies.forEach { (key, value) in
                let testIcon: UIImageView = {
                    let imgView = UIImageView()
                    imgView.translatesAutoresizingMaskIntoConstraints = false
                    imgView.contentMode = .scaleAspectFit
                    imgView.tintColor = CustomColor.platinum
                    return imgView
                }()

                let testLabel: UILabel = {
                    let lbl = UILabel()
                    lbl.translatesAutoresizingMaskIntoConstraints = false
                    lbl.textColor = CustomColor.platinum
                    lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                    return lbl
                }()

                let testView: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.backgroundColor = CustomColor.silverSynergy
                    view.layer.cornerRadius = 2.0
                    return view
                }()


                testLabel.text = String(value)
                testIcon.image = UIImage(named: "\(key)")

                testView.addSubview(testIcon)
                testView.addSubview(testLabel)

                testIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
                testIcon.leadingAnchor.constraint(equalTo: testView.leadingAnchor).isActive = true
                testIcon.topAnchor.constraint(equalTo: testView.topAnchor).isActive = true
                testIcon.trailingAnchor.constraint(equalTo: testLabel.leadingAnchor).isActive = true
                testIcon.bottomAnchor.constraint(equalTo: testView.bottomAnchor).isActive = true
                testLabel.leadingAnchor.constraint(equalTo: testIcon.trailingAnchor).isActive = true
                testLabel.topAnchor.constraint(equalTo: testView.topAnchor).isActive = true
                testLabel.trailingAnchor.constraint(equalTo: testView.trailingAnchor, constant: -6).isActive = true
                testLabel.bottomAnchor.constraint(equalTo: testView.bottomAnchor).isActive = true


                synergiesStackView.addArrangedSubview(testView)
            }
            
            titleLabel.text = title
            setTeamCompChampImages(endGameChamps)
            setTierLabelAndColor(tier)
        }
    }
    
    
    //MARK:- Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupCellContent()
    }
    
    
    //MARK: Set Team Comp Champ Images
    fileprivate func setTeamCompChampImages(_ endGameChamps: [[String : Any]]) {
        var champNames = [String]()
        let champImgArray = [champImageOne, champImageTwo, champImageThree, champImageFour, champImageFive, champImageSix, champImageSeven, champImageEight]
        
        endGameChamps.forEach { (champ) in
            guard let champName = champ["name"] else { return }
            champNames.append(champName as! String)
        }
        
        for i in 0..<8 {
            if i < champNames.count {
                champImgArray[i].sd_setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/9.13.1/img/champion/\(champNames[i]).png"))
            } else {
                champImgArray[i].image = nil
                champImgArray[i].isHidden = true
            }
        }
    }
    
    
    //MARK: Set Tier Label And Color
    fileprivate func setTierLabelAndColor(_ tier: Int) {
        switch tier {
        case 0:
            teamCompTier.text = "S Tier"
            teamCompTier.backgroundColor = CustomColor.sTier
        case 1:
            teamCompTier.text = "A Tier"
            teamCompTier.backgroundColor = CustomColor.aTier
        case 2:
            teamCompTier.text = "B Tier"
            teamCompTier.backgroundColor = CustomColor.bTier
        case 3:
            teamCompTier.text = "C Tier"
            teamCompTier.backgroundColor = CustomColor.cTier
        case 4:
            teamCompTier.text = "D Tier"
            teamCompTier.backgroundColor = CustomColor.dTier
        default:
            teamCompTier.text = "E Tier"
            teamCompTier.backgroundColor = CustomColor.eTier
        }
    }
    
    
    //MARK:- Team Comp Title & Tier
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()
    
    let teamCompTier: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = CustomColor.richBlack
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 6.0
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return lbl
    }()
    
    
    //MARK:- Champ Images
    let champImageOne = TeamCompChampImage(image: nil)
    let champImageTwo = TeamCompChampImage(image: nil)
    let champImageThree = TeamCompChampImage(image: nil)
    let champImageFour = TeamCompChampImage(image: nil)
    let champImageFive = TeamCompChampImage(image: nil)
    let champImageSix = TeamCompChampImage(image: nil)
    let champImageSeven = TeamCompChampImage(image: nil)
    let champImageEight = TeamCompChampImage(image: nil)
    
    
//    //MARK:- Champ Synergy Badges
//    let synergyOneIcon: UIImageView = {
//        let imgView = UIImageView()
//        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.contentMode = .scaleAspectFit
//        imgView.tintColor = CustomColor.platinum
//        return imgView
//    }()
//
//    let synergyOneLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.textColor = CustomColor.platinum
//        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
//        return lbl
//    }()
//
//    let synergyOneView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = CustomColor.goldSynergy
//        view.layer.cornerRadius = 2.0
//        return view
//    }()
//
//    let synergyTwoIcon: UIImageView = {
//        let imgView = UIImageView()
//        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.contentMode = .scaleAspectFit
//        imgView.tintColor = CustomColor.platinum
//        return imgView
//    }()
//
//    let synergyTwoLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.textColor = CustomColor.platinum
//        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
//        return lbl
//    }()
//
//    let synergyTwoView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = CustomColor.silverSynergy
//        view.layer.cornerRadius = 2.0
//        return view
//    }()
//
//    let synergyThreeIcon: UIImageView = {
//        let imgView = UIImageView()
//        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.contentMode = .scaleAspectFit
//        imgView.tintColor = CustomColor.platinum
//        return imgView
//    }()
//
//    let synergyThreeLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.textColor = CustomColor.platinum
//        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
//        return lbl
//    }()
//
//    let synergyThreeView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = CustomColor.bronzeSynergy
//        view.layer.cornerRadius = 2.0
//        return view
//    }()
    
    lazy var synergiesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing =  4
        return stackView
    }()
    
    
    //MARK:- Setup Cell
    fileprivate func setupCell() {
        accessoryType = .disclosureIndicator
        backgroundColor = CustomColor.richBlack
        separatorInset.left = 0
        
    }
    
    
    //MARK:- Setup Cell Content
    fileprivate func setupCellContent() {
        
        
        //MARK: Title & Tier
        addSubview(titleLabel)
        addSubview(teamCompTier)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        teamCompTier.topAnchor.constraint(equalTo: topAnchor).isActive = true
        teamCompTier.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        teamCompTier.widthAnchor.constraint(equalToConstant: 60).isActive = true
        teamCompTier.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        
        //MARK: Champ Images
        addSubview(champImageOne)
        addSubview(champImageTwo)
        addSubview(champImageThree)
        addSubview(champImageFour)
        addSubview(champImageFive)
        addSubview(champImageSix)
        addSubview(champImageSeven)
        addSubview(champImageEight)
        
        let champImgSize: CGFloat = 35
        let champImgSpacing: CGFloat = 6
        champImageOne.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        champImageOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        champImageOne.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageOne.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true
        
        champImageTwo.topAnchor.constraint(equalTo: champImageOne.topAnchor).isActive = true
        champImageTwo.leadingAnchor.constraint(equalTo: champImageOne.trailingAnchor, constant: champImgSpacing).isActive = true
        champImageTwo.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageTwo.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true

        champImageThree.topAnchor.constraint(equalTo: champImageTwo.topAnchor).isActive = true
        champImageThree.leadingAnchor.constraint(equalTo: champImageTwo.trailingAnchor, constant: champImgSpacing).isActive = true
        champImageThree.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageThree.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true
        
        champImageFour.topAnchor.constraint(equalTo: champImageThree.topAnchor).isActive = true
        champImageFour.leadingAnchor.constraint(equalTo: champImageThree.trailingAnchor, constant: champImgSpacing).isActive = true
        champImageFour.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageFour.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true
        
        champImageFive.topAnchor.constraint(equalTo: champImageFour.topAnchor).isActive = true
        champImageFive.leadingAnchor.constraint(equalTo: champImageFour.trailingAnchor, constant: champImgSpacing).isActive = true
        champImageFive.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageFive.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true
        
        champImageSix.topAnchor.constraint(equalTo: champImageFive.topAnchor).isActive = true
        champImageSix.leadingAnchor.constraint(equalTo: champImageFive.trailingAnchor, constant: champImgSpacing).isActive = true
        champImageSix.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageSix.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true
        
        champImageSeven.topAnchor.constraint(equalTo: champImageSix.topAnchor).isActive = true
        champImageSeven.leadingAnchor.constraint(equalTo: champImageSix.trailingAnchor, constant: champImgSpacing).isActive = true
        champImageSeven.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageSeven.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true
        
        champImageEight.topAnchor.constraint(equalTo: champImageSeven.topAnchor).isActive = true
        champImageEight.leadingAnchor.constraint(equalTo: champImageSeven.trailingAnchor, constant: champImgSpacing).isActive = true
        champImageEight.heightAnchor.constraint(equalToConstant: champImgSize).isActive = true
        champImageEight.widthAnchor.constraint(equalToConstant: champImgSize).isActive = true
        
        
        
        //MARK: Synergy Badges
        addSubview(synergiesStackView)
        synergiesStackView.leadingAnchor.constraint(equalTo: champImageOne.leadingAnchor).isActive = true
        synergiesStackView.topAnchor.constraint(equalTo: champImageOne.bottomAnchor, constant: 8).isActive = true
        synergiesStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true

        
//        synergyOneView.addSubview(synergyOneIcon)
//        synergyOneView.addSubview(synergyOneLabel)
//        synergyTwoView.addSubview(synergyTwoIcon)
//        synergyTwoView.addSubview(synergyTwoLabel)
//        synergyThreeView.addSubview(synergyThreeIcon)
//        synergyThreeView.addSubview(synergyThreeLabel)
//
//        let iconWidth: CGFloat = 25
//        let trailSpacing: CGFloat = -6
//        synergyOneIcon.widthAnchor.constraint(equalToConstant: iconWidth).isActive = true
//        synergyOneIcon.leadingAnchor.constraint(equalTo: synergyOneView.leadingAnchor).isActive = true
//        synergyOneIcon.topAnchor.constraint(equalTo: synergyOneView.topAnchor).isActive = true
//        synergyOneIcon.trailingAnchor.constraint(equalTo: synergyOneLabel.leadingAnchor).isActive = true
//        synergyOneIcon.bottomAnchor.constraint(equalTo: synergyOneView.bottomAnchor).isActive = true
//        synergyOneLabel.leadingAnchor.constraint(equalTo: synergyOneIcon.trailingAnchor).isActive = true
//        synergyOneLabel.topAnchor.constraint(equalTo: synergyOneView.topAnchor).isActive = true
//        synergyOneLabel.trailingAnchor.constraint(equalTo: synergyOneView.trailingAnchor, constant: trailSpacing).isActive = true
//        synergyOneLabel.bottomAnchor.constraint(equalTo: synergyOneView.bottomAnchor).isActive = true
//
//        synergyTwoIcon.widthAnchor.constraint(equalToConstant: iconWidth).isActive = true
//        synergyTwoIcon.leadingAnchor.constraint(equalTo: synergyTwoView.leadingAnchor).isActive = true
//        synergyTwoIcon.topAnchor.constraint(equalTo: synergyTwoView.topAnchor).isActive = true
//        synergyTwoIcon.trailingAnchor.constraint(equalTo: synergyTwoLabel.leadingAnchor).isActive = true
//        synergyTwoIcon.bottomAnchor.constraint(equalTo: synergyTwoView.bottomAnchor).isActive = true
//        synergyTwoLabel.leadingAnchor.constraint(equalTo: synergyTwoIcon.trailingAnchor).isActive = true
//        synergyTwoLabel.topAnchor.constraint(equalTo: synergyTwoView.topAnchor).isActive = true
//        synergyTwoLabel.trailingAnchor.constraint(equalTo: synergyTwoView.trailingAnchor, constant: trailSpacing).isActive = true
//        synergyTwoLabel.bottomAnchor.constraint(equalTo: synergyTwoView.bottomAnchor).isActive = true
//
//        synergyThreeIcon.widthAnchor.constraint(equalToConstant: iconWidth).isActive = true
//        synergyThreeIcon.leadingAnchor.constraint(equalTo: synergyThreeView.leadingAnchor).isActive = true
//        synergyThreeIcon.topAnchor.constraint(equalTo: synergyThreeView.topAnchor).isActive = true
//        synergyThreeIcon.trailingAnchor.constraint(equalTo: synergyThreeLabel.leadingAnchor).isActive = true
//        synergyThreeIcon.bottomAnchor.constraint(equalTo: synergyThreeView.bottomAnchor).isActive = true
//        synergyThreeLabel.leadingAnchor.constraint(equalTo: synergyThreeIcon.trailingAnchor).isActive = true
//        synergyThreeLabel.topAnchor.constraint(equalTo: synergyThreeView.topAnchor).isActive = true
//        synergyThreeLabel.trailingAnchor.constraint(equalTo: synergyThreeView.trailingAnchor, constant: trailSpacing).isActive = true
//        synergyThreeLabel.bottomAnchor.constraint(equalTo: synergyThreeView.bottomAnchor).isActive = true
    }
    
    
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
