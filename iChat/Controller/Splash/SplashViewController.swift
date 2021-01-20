//
//  SplashViewController.swift
//  iChat
//
//  Created by Lucas Pereira on 07/10/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var isUserLoggedIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isUserLoggedIn {
            let controller = FriendsController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
//            Navigator.goToLogin()
        }
    }
}
