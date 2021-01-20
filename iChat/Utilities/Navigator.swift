//
//  Navigator.swift
//  iChat
//
//  Created by Lucas Pereira on 07/10/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//

import UIKit

struct Navigator {
    public static func goToLogin() {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = controller
    }
}
