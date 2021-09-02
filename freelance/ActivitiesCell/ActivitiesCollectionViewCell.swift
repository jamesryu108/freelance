//
//  ActivitiesCollectionViewCell.swift
//  ActivitiesCollectionViewCell
//
//  Created by James Ryu on 2021-09-01.
//

import UIKit

class ActivitiesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Labels
    
    /// Activity label
    let activityLabel: CustomLabel = {
        
        let lbl = CustomLabel()
        
            lbl.text = "You made a manual transfer. And then you started with it."
            lbl.backgroundColor = .systemGreen
            lbl.numberOfLines = 0
        return lbl
    }()
    
    /// Price label
    let priceLabel: CustomLabel = {
        
        let lbl = CustomLabel()
        
        lbl.attributedText = NSAttributedString(string: "$2.00\n", attributes: [NSAttributedString.Key.strokeColor: UIColor.systemGreen])
            lbl.backgroundColor = .systemBlue
            lbl.numberOfLines = 2
            lbl.textAlignment = .center
        
        return lbl
    }()
    
    /// Date label
    let dateLabel: CustomLabel = {
        
        let lbl = CustomLabel()
        
            lbl.text = "01 Sep 2021"
            lbl.textColor = .systemGray3
            lbl.backgroundColor = .systemIndigo
        
        return lbl
    }()
    
    // MARK: - UIImageView
    
    /// Profile pic
    let profilePic: UIImageView = {
        
        let imageView = UIImageView()
        
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .systemOrange
            
        return imageView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .systemBrown
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    
    /// Set up UI
    func setupUI() {
        
        self.contentView.addSubview(profilePic)
            
        self.contentView.addSubview(activityLabel)
        
        self.contentView.addSubview(priceLabel)
        
        self.contentView.addSubview(dateLabel)
    }
}
