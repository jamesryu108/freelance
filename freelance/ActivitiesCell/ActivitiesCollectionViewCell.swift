//
//  ActivitiesCollectionViewCell.swift
//  ActivitiesCollectionViewCell
//
//  Created by James Ryu on 2021-09-01.
//

import UIKit

class ActivitiesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Font objects
    
    /// instance of MyFontCollections class that manages font being used in this application.
    lazy var fontCollection = MyFontCollections(fontName: .funkisQText)
    
    // MARK: - Labels
    
    /// Activity label
    let activityLabel: CustomLabel = {
        
        let lbl = CustomLabel()
        
            lbl.text = "You rounded up at Whole Foods Market."
            lbl.numberOfLines = 0
        return lbl
    }()
    
    /// Price label
    lazy var priceLabel: CustomLabel = {
        
        let lbl = CustomLabel()
        
            lbl.numberOfLines = 2
            lbl.textAlignment = .center
            
        return lbl
    }()
    
    /// Date label
    let dateLabel: CustomLabel = {
        
        let lbl = CustomLabel(size: 12, weight: .regular)
        
            lbl.text = "Today"
            lbl.textColor = .systemGray2
        
        return lbl
    }()

    // MARK: - UIImageView
    
    /// Profile pic
    let profilePic: UIImageView = {
        
        let imageView = UIImageView()
        
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
        return imageView
    }()

    // MARK: - Separator
    
    /// Separator that sits at the bottom of the cell to serve as a separator.
    let separator: UIView = {
        
        let view = UIView()
        
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemGray3
        
        return view
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        
        super.init(frame: frame)
                
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
        
        self.contentView.addSubview(separator)
        
        profilePic.layer.cornerRadius = 24
        profilePic.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            profilePic.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profilePic.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            profilePic.heightAnchor.constraint(equalToConstant: 48),
            profilePic.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 16),
            dateLabel.leftAnchor.constraint(equalTo: profilePic.rightAnchor, constant: 8),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
            dateLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.60)
        ])
        
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            separator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            separator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
