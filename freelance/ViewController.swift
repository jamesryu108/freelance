//
//  ViewController.swift
//  freelance
//
//  Created by James Ryu on 2021-09-01.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Data source
    
    /// Download all activities and then download it here.
    var allActivities: [SmallActivities] = []
    
    /// Array that holds Users class.
    var userArray: [Users] = []
    
    /// Store the date of the oldest date here.
    var oldestDataDate: Date = Date()
    
    /// Today's date.
    lazy var todayDate: Date = Date().formatStringDateToDate(format: "yyyy-MM-dd")
    
    /// Date that you reached back to
    lazy var latestDate: Date = todayDate - (86400 * 13)
    
    // MARK: - View objects
        
    /// UICollectionview that lists all activities data
        let collectionView: UICollectionView = {
            
            let layout = UICollectionViewFlowLayout()
            
                layout.scrollDirection = .vertical
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
            
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
                cv.translatesAutoresizingMaskIntoConstraints = false
                cv.backgroundColor = .systemBackground
                
            return cv
        }()
    
    // MARK: - For styling
    
    /// instance of MyFontCollections class that manages font being used in this application.
    let fontCollection = MyFontCollections(fontName: .funkisQText)
    
    /// UIFont for labels set here.
    lazy var fontOfTheAdjustableLabel = fontCollection.returnFont(size: 14, weight: .light)
    
    /// Indicator that runs while something is loading. Then it disappears once task finishes.
    var activityIndicator: UIActivityIndicatorView = {
        
        let view = UIActivityIndicatorView()
        
            view.translatesAutoresizingMaskIntoConstraints = false
            view.color = .white
            view.backgroundColor = .systemGray
        
        return view
    }()
    
    // MARK: - Calculate heights of each cell, depending on height of the UILabel
    
    /// Based on font size/style and the length of the message, you can determine the height of each cell, and then store it here for UICollectionView, so they can automatically size them.
    var heightTracker: [CGFloat] = []
    
    // MARK: - Views
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setting the font style of title of navigationBar
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: fontCollection.returnFont(size: 20, weight: .medium)]
        
        // Set the title
        title = "Activity"
        
        // Set up activity indicator
        setupActivityIndicator()

        // Fetch initial activities data
        fetchActivity(fromDate: latestDate, toDate: todayDate)
    }
    
    // MARK: - fetch functions
    
    func fetchActivity(fromDate: Date, toDate: Date) {
        
        FetchActivities().getActivities(from: URL(string: "http://qapital-ios-testtask.herokuapp.com/activities?from=\(fromDate.formatYourDate(format: "yyyy-MM-dd"))&to=\(toDate.formatYourDate(format: "yyyy-MM-dd"))")!) { [self] data, response, error in
        
            DispatchQueue.main.async {
                activityIndicator.startAnimating()
            }
            
            guard error == nil else {
                print("error fetch: \(error?.localizedDescription)")
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                }
                return
            }
            
            let activities = data?.activities
                        
            oldestDataDate = (data?.oldest.toDate(format: "yyyy-MM-dd'T'HH:mm:ssXXX"))!
            
            /// Get all urls
            var urls: [String] = []
            
            
            
            // Append all SmallActivities to the allActivities array
            
            for i in 0..<activities!.count {
                
                allActivities.append(activities![i])
                
                DispatchQueue.main.async {
                    heightTracker.append(heightForView(text: activities![i].message, font: fontOfTheAdjustableLabel, width: UIScreen.main.bounds.width * 0.60) + 72)
                }
                
                urls.append("\(activities![i].userId)")
            }
            
            print("height tracker: \(heightTracker)")
            
            // Sort the allActivities so that most recent activities data  will show up first in CV
            allActivities = allActivities.sorted { $0.timestamp > $1.timestamp}
            
            // Get user data. Note that first user data downloaded will be cached.
            UserData().getUsers(from: urls) { data, response, error in
                
                print("data: \(data)")
                
                for dd in data! {
                    userArray.append(Users(dict: dd))
                }
                
                DispatchQueue.main.async {

                    // Initially, allActivities counts is 14 to start off. So you will only set up CollectionView
                    if allActivities.count == 14 {
                                                
                        setupCollectionView()
                    }
 
                    collectionView.reloadData()
                    
                    todayDate = todayDate.subtract2Weeks()
                    
                    latestDate = todayDate.subtract2Weeks() + 86400

                    activityIndicator.stopAnimating()
                }
            }
        }
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
    
    /// measure height
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
         
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
         
        return label.frame.height
    }
}

// MARK: - UIActivityIndicator function

extension ViewController {
        
    /// Setting up activity indicator, just in case it is needed. Good time to use this is when fetching a data and it takes time to do so.
    func setupActivityIndicator() {
        
        self.view.addSubview(activityIndicator)
        
        activityIndicator.anc(t: nil, ver: nil, b: nil, l: nil, hor: nil, r: nil, w: 150, h: 150, cX: self.view.centerXAnchor, cY: self.view.centerYAnchor)
        
        activityIndicator.layer.cornerRadius = 150 / 16
        
        activityIndicator.isHidden = false
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allActivities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ActivitiesCollectionViewCell
        
        cell.profilePic.layer.cornerRadius = 24
        cell.profilePic.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            cell.activityLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16),
            cell.activityLabel.leftAnchor.constraint(equalTo: cell.profilePic.rightAnchor, constant: 8),
            cell.activityLabel.heightAnchor.constraint(equalToConstant: heightTracker[indexPath.row] - 72),
            cell.activityLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.60)
        ])
        
        
        NSLayoutConstraint.activate([
            cell.priceLabel.topAnchor.constraint(equalTo:cell.contentView.topAnchor, constant: 16),
            cell.priceLabel.leftAnchor.constraint(equalTo: cell.activityLabel.rightAnchor, constant: 8),
            cell.priceLabel.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: -8),
            cell.priceLabel.heightAnchor.constraint(equalToConstant: (heightTracker[indexPath.row] - 56) / 2)
        ])
 
        // font and style of the font for activityLabel is set here
        cell.activityLabel.font = fontOfTheAdjustableLabel
      
        let str = allActivities[indexPath.row].message.replacingOccurrences(of: "<strong>", with: "").replacingOccurrences(of: "</strong>", with: "")
        
        let index = allActivities[indexPath.row].message.indicesOf(string: "<strong>")
        let index2 = allActivities[indexPath.row].message.indicesOf(string: "</strong>")

        var secondIndexOpen: Int?
        var secondIndexClose: Int?
        
        var joinedChar: String?
        
        let filteredText = allActivities[indexPath.row].message.replacingOccurrences(of: "<strong>", with: "").replacingOccurrences(of: "</strong>", with: "")
        
        let attrStr = NSMutableAttributedString(string: filteredText)
        
        if index.count > 1 {
            
            secondIndexOpen = index[1] + 8 - 25

            secondIndexClose = index2[1] - 25 - 1

            let char = Array(str)[secondIndexOpen!...secondIndexClose!]

            joinedChar = char.map { String($0) }
                .joined(separator: "")
                        
            let rangeOfPlace = filteredText.range(of: joinedChar!)
            
            let rrr = NSRange(rangeOfPlace!, in: filteredText)
            
            attrStr.addAttributes([.font: fontCollection.returnFont(size: 14, weight: .bold)], range: rrr)
        }
        
        // Find range of the name

        let userNameIndex: Int = userArray.firstIndex(where: {$0.userId == allActivities[indexPath.row].userId})!
        
        let rangeOfName = filteredText.range(of: userArray[userNameIndex].displayName!)
                
        if rangeOfName != nil {
        
            let nsRangeOfName = NSRange(rangeOfName!, in: filteredText)
            
            attrStr.addAttributes([.font: fontCollection.returnFont(size: 14, weight: .bold)], range: nsRangeOfName)
        }
        
        if rangeOfName == nil {
        
            let nsRangeOfName = NSRange(location: 0, length: 3)
            
            attrStr.addAttributes([.font: fontCollection.returnFont(size: 14, weight: .bold)], range: nsRangeOfName)
        }
        
        cell.activityLabel.attributedText = attrStr
        
        let priceAttrStr = NSMutableAttributedString(string: "$\(allActivities[indexPath.row].amount)")
        
        priceAttrStr.addAttributes([.font: fontCollection.returnFont(size: 14, weight: .bold), .foregroundColor: UIColor(red: 88/255, green: 191/255, blue: 23/255, alpha: 1.0)], range: NSRange(location: 0, length: "$\(allActivities[indexPath.row].amount)".count))
        
        cell.priceLabel.attributedText = priceAttrStr
                
        cell.dateLabel.text = "\(allActivities[indexPath.row].timestamp)"
        
        cell.profilePic.loadImageToTheCache(userArray[indexPath.row].avatarUrl!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row + 1) == allActivities.count && oldestDataDate.timeIntervalSince(allActivities[allActivities.count - 1].timestamp) < 0 {
                        
            fetchActivity(fromDate: latestDate, toDate: todayDate)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: heightTracker[indexPath.row])
    }
}
