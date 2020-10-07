//
//  FriendsController.swift
//  iChat
//
//  Created by Lucas Pereira on 21/07/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//

import UIKit
import CoreData

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var messages: [Message]?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialNavBar()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        setupData()
    }
    
    //MARK:- Functions
    func initialNavBar() {
        let backButton: UIBarButtonItem = UIBarButtonItem(image: nil, style: .done, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        let userProfileImageView: UIImageView = UIImageView(image: UIImage(named: "lucas"))
        let userProfileView: UIView = UIView()
        userProfileView.addSubview(userProfileImageView)
        userProfileImageView.layer.cornerRadius = 15
        userProfileImageView.clipsToBounds = true
        
        let buttonItem: UIBarButtonItem = UIBarButtonItem(customView: userProfileView)
        buttonItem.action = #selector(openPersonalViewController)
        navigationItem.setLeftBarButton(buttonItem, animated: true)
        navigationItem.title = "iChat"
        
        userProfileView.addConstraintsWithFormat(format: "H:|[v0(30)]", views: userProfileImageView)
        userProfileView.addConstraintsWithFormat(format: "V:|[v0(30)]|", views: userProfileImageView)
    }
    
    @objc func openPersonalViewController() {
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        if let message = messages?[indexPath.item] {
            cell.message = message
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = ChatLogController(collectionViewLayout: layout)
        controller.friend = messages?[indexPath.item].friend
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

class MessageCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Color.lightBlue : Color.white
            nameLabel.textColor = isHighlighted ? Color.white : Color.textColorPrimary
            messageLabel.textColor = isHighlighted ? Color.white : Color.textColorSecundary
            timeLabel.textColor = isHighlighted ? Color.white : Color.textColorPrimary
        }
    }
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.friend?.name
            if let profileImageName = message?.friend?.profileImageName {
            profileImageView.image = UIImage(named: profileImageName)
            hasReadImageView.image = UIImage(named: profileImageName)
            }
            messageLabel.text = message?.text
            if let date = message?.date {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "H:mm"
                
                let elapsedTimeInSeconds = NSDate().timeIntervalSince(date)
                
                let secondInDays: TimeInterval = 60 * 60 * 24
                
                if elapsedTimeInSeconds > 7 * secondInDays {
                    dateFormatter.dateFormat = "dd/MM/yy"
                    
                } else if elapsedTimeInSeconds > secondInDays {
                    dateFormatter.dateFormat = "EEE"
                }
                timeLabel.text = dateFormatter.string(from: date as Date)
            }
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textColorPrimary
        label.font = Font.fontTextBold(size: 18)
        label.text = "friend_name"
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textColorSecundary
        label.font = Font.fontTextRegular(size: 14)
        label.text = "friend_time"
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textColorPrimary
        label.font = Font.fontTextRegular(size: 14)
        label.textAlignment = .right
        label.text = "12:51"
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        setupContainerView()
        
        profileImageView.image = UIImage(named: "zuckprofile")
        hasReadImageView.image = UIImage(named: "zuckprofile")
        
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
        
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLineView)

    }
    
    private func setupContainerView() {
        let containerView = UIView()
        addSubview(containerView)
        
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
        
        containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
        
        containerView.addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)
    }
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setupViews() {
    }
}
