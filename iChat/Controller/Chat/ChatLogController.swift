//
//  ChatLogController.swift
//  iChat
//
//  Created by Lucas Pereira on 23/07/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    
    private let cellId: String = "cellId"
    
    var previousPosition: CGRect = CGRect.zero
    var indexHeight: Bool = false
    var constraintHeightTextField: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    var friend: Friend? {
        didSet {
//            navigationItem.title = friend?.name
            var friendProfileView: UIImageView!
            let friendName = UILabel()
            
            let friendTopButton: UIView = {
                let view = UIView()
                let image = UIImageView(image: UIImage(named: friend?.profileImageName ?? ""))
                image.layer.cornerRadius = 17
                image.clipsToBounds = true
                friendName.text = friend?.name ?? "Unkown"
                friendName.font = Font.fontTextBold(size: 15)
                friendProfileView = image
                friendProfileView.contentMode = .scaleAspectFill
                view.addSubview(friendProfileView)
                view.addSubview(friendName)

                return view
            }()

            let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .plain, target: self, action: nil)
            rightBarButtonItem.tintColor = Color.lightBlue
            
            navigationItem.titleView = friendTopButton
            navigationItem.rightBarButtonItem = rightBarButtonItem
            
            friendTopButton.addConstraintsWithFormat(format: "H:|[v0(34)]-8-[v1]-100-|", views: friendProfileView, friendName)
            friendTopButton.addConstraintsWithFormat(format: "V:|[v0(34)]|", views: friendProfileView)
            friendTopButton.addConstraintsWithFormat(format: "V:|-10-[v0]", views: friendName)


            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sorted(by: {$0.date?.compare($1.date! as Date) == .orderedAscending})
        }
    }
    
    var messages: [Message]?
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.extraLightGray
        return view
    }()
    
    let inputTextView: UITextView = {
        let textField = UITextView()
        textField.font = Font.systemRegular(size: 16)
        textField.backgroundColor = Color.white
        textField.textContainerInset = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 8)
        textField.layer.cornerRadius = 16
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Color.lightGray.withAlphaComponent(0.3).cgColor
        textField.textContainer.lineBreakMode = .byWordWrapping
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        button.tintColor = Color.lightBlue
        return button
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextView.delegate = self
        tabBarController?.tabBar.isHidden = true
        collectionView.backgroundColor = Color.white
        collectionView.alwaysBounceVertical = true
        register()
        createContainerView()
        setupInputComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            print(keyboardFrame)
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height+34 : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completion) in
                if isKeyboardShowing {
                    self.collectionView.scrollToBottom()
                }
            })
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == inputTextView {
            adjustTextViewHeight()
        }
    }
    
    private func createContainerView() {
        view.addSubview(messageInputContainerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
        heightConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        view.addConstraint(heightConstraint!)
        
        //collectionView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor, constant: 0).isActive = true
        
        
    }
    
    private func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = Color.lightGray.withAlphaComponent(0.3)
        
        messageInputContainerView.addSubview(inputTextView)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        
        messageInputContainerView.addConstraintsWithFormat(format: "H:|-12-[v0]-8-[v1(32)]-12-|", views: inputTextView, sendButton)
        
        messageInputContainerView.addConstraintsWithFormat(format: "V:|-6-[v0]", views: inputTextView)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|-6-[v0(32)]", views: sendButton)
        
        messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0(0.5)]", views: topBorderView)
        
        constraintHeightTextField = NSLayoutConstraint(item: inputTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32)
        messageInputContainerView.addConstraint(constraintHeightTextField!)
    }
    
    func adjustTextViewHeight() {
        let position:UITextPosition = inputTextView.endOfDocument
        let currentPosition:CGRect = inputTextView.caretRect(for: position)
        if (currentPosition.origin.y > previousPosition.origin.y) {
            previousPosition = currentPosition
            self.inputTextView.frame = currentPosition
            if indexHeight {
                self.constraintHeightTextField.constant = self.constraintHeightTextField.constant+currentPosition.height
                self.heightConstraint.constant = self.heightConstraint.constant+currentPosition.height
                }
            self.indexHeight = true
//        } else if (currentPosition.origin.y < previousPosition.origin.y) && self.constraintHeightTextField.constant > self.constraintHeight {
//            previousPosition = currentPosition
//            self.constraintHeightTextField.frame = currentPosition
//            self.constraintHeightTextField.constant = self.constraintHeightTextField.constant-currentPosition.height
        }
    }
    
    private func register() {
        collectionView.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        cell.messageTextView.text = messages?[indexPath.row].text
        
        if let message = messages?[indexPath.item], let messageText = message.text, let profileImageName = message.friend?.profileImageName {
            
            //TODO: Make a condition to only show this icon if the last message was from another person or took too long
            cell.profileImageView.image = UIImage(named: profileImageName)
            
            let size: CGSize = CGSize(width: 250, height: 1000)
            let options: NSStringDrawingOptions = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [ NSAttributedString.Key.font : Font.fontTextRegular(size: 14)], context: nil)

            if !message.isSender {
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: 48, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
                
                cell.profileImageView.isHidden = false
                cell.messageTextView.textColor = Color.textColorPrimary
            } else {
                
                // User/Local Sending Messege
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 14, y: 2, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 8 - 8, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
                
                cell.profileImageView.isHidden = true
                
                cell.textBubbleView.backgroundColor = Color.lightBlue
                cell.messageTextView.textColor = Color.white
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].text {
            let size: CGSize = CGSize(width: 250, height: 1000)
            let options: NSStringDrawingOptions = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimated = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [ NSAttributedString.Key.font : Font.fontTextRegular(size: 14)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimated.height + 20)
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextView.endEditing(true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.size.width, height: 52)
//    }
}

class ChatLogMessageCell: BaseCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.font = Font.fontTextRegular(size: 14)
        textView.textColor = Color.textColorPrimary
        textView.backgroundColor = Color.clear
        textView.text = "Exemple"
        return textView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.extraLightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
       return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = Color.white
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        
        addSubview(profileImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(30)]|", views: profileImageView)
        profileImageView.backgroundColor = Color.blue
        
    }
}

extension UICollectionView {
func scrollToBottom(animated: Bool = true) {
    let section = self.numberOfSections
    if section > 0 {
        let row = self.numberOfItems(inSection: section - 1)
        if row > 0 {
            self.scrollToItem(at: IndexPath(row: row-1, section: section-1), at: .bottom, animated: animated)
            }
        }
    }
}

