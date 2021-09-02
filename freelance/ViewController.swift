//
//  ViewController.swift
//  freelance
//
//  Created by James Ryu on 2021-09-01.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - View objects
        
    /// UICollectionview that lists all activities data
        let collectionView: UICollectionView = {
            
            let layout = UICollectionViewFlowLayout()
            
                layout.scrollDirection = .vertical
            
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
                cv.translatesAutoresizingMaskIntoConstraints = false
                cv.backgroundColor = .systemBackground
            
            return cv
        }()
    
    // MARK: - For styling
    
    /// instance of MyFontCollections class that manages font being used in this application.
    let fontCollection = MyFontCollections(fontName: .funkisQText)
    
    /// Indicator that runs while something is loading. Then it disappears once task finishes.
    var activityIndicator: UIActivityIndicatorView = {
        
        let view = UIActivityIndicatorView()
        
            view.translatesAutoresizingMaskIntoConstraints = false
            view.color = .systemBlue
            view.backgroundColor = .systemGray
        
        return view
    }()
    
    // MARK: - Views
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setting the font style of title of navigationBar
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: fontCollection.returnFont(size: 20, weight: .medium)]
        
        // Set the title
        title = "Activity"
        
        // Do any additional setup after loading the view.
        setupCollectionView()
        
        // Set up activity indicator
        setupActivityIndicator()
    }

    // MARK: - Set up CV
    
    /// Set up the collectionView
       func setupCollectionView() {
           
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.register(ActivitiesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
           
           self.view.addSubview(collectionView)
           
           NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
           ])
       }
}

// MARK: - UIActivityIndicator function

extension ViewController {
        
    /// Setting up activity indicator, just in case it is needed. Good time to use this is when fetching a data and it takes time to do so.
    func setupActivityIndicator() {
        
        self.view.addSubview(activityIndicator)
        
        activityIndicator.anc(t: nil, ver: nil, b: nil, l: nil, hor: nil, r: nil, w: 150, h: 150, cX: self.view.centerXAnchor, cY: self.view.centerYAnchor)
        
        activityIndicator.layer.cornerRadius = 150 / 16
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ActivitiesCollectionViewCell
        
        NSLayoutConstraint.activate([
            cell.profilePic.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16),
            cell.profilePic.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 16),
            cell.profilePic.heightAnchor.constraint(equalToConstant: 56),
            cell.profilePic.widthAnchor.constraint(equalToConstant: 56)
        ])
        
        cell.profilePic.layer.cornerRadius = 28
        
        NSLayoutConstraint.activate([
            cell.activityLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16),
            cell.activityLabel.leftAnchor.constraint(equalTo: cell.profilePic.rightAnchor, constant: 8),
            cell.activityLabel.heightAnchor.constraint(equalToConstant: 64),
            cell.activityLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.60)
        ])
        
        NSLayoutConstraint.activate([
            cell.dateLabel.topAnchor.constraint(equalTo: cell.activityLabel.bottomAnchor, constant: 8),
            cell.dateLabel.leftAnchor.constraint(equalTo: cell.profilePic.rightAnchor, constant: 8),
            cell.dateLabel.heightAnchor.constraint(equalToConstant: 24),
            cell.dateLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.60)
        ])
        
        NSLayoutConstraint.activate([
            cell.priceLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16),
            cell.priceLabel.leftAnchor.constraint(equalTo: cell.activityLabel.rightAnchor, constant: 8),
            cell.priceLabel.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: -8),
            cell.priceLabel.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        cell.profilePic.loadImageToTheCache("http://qapital-ios-testtask.herokuapp.com/avatars/mikael.jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
}

