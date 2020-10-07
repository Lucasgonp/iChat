//
//  Account.swift
//  iChat
//
//  Created by Lucas Pereira on 27/07/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//

import UIKit

struct Account {
    static var name: String = "Lucas Pereira"
    static var profileImageName: String = "lucas"
    static var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: profileImageName)
        return imageView
    }()
}
