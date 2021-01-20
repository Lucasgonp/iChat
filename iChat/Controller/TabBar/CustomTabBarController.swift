//
//  CustomTabBarController.swift
//  iChat
//
//  Created by Lucas Pereira on 23/07/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialData()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        let navControllerCalls = createDummyNavControllerWithTitle(title: "Chamadas", imageName: "calls")
        let navControllerPeople = createDummyNavControllerWithTitle(title: "Contatos", imageName: "people")
        let navControllerGroups = createDummyNavControllerWithTitle(title: "Grupos", imageName: "groups")
        let navControllerSettings = createDummyNavControllerWithTitle(title: "Configurações", imageName: "settings")
        
        self.viewControllers?.append(navControllerCalls)
        self.viewControllers?.append(navControllerGroups)
        self.viewControllers?.append(navControllerPeople)
        self.viewControllers?.append(navControllerSettings)
    }
    
    private func initialData() {
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recente"
        recentMessagesNavController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font.fontTextRegular(size: 20)]
        recentMessagesNavController.tabBarItem.image =  UIImage(named: "recent")
        viewControllers = [recentMessagesNavController]
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font.fontTextRegular(size: 14)]

        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
}
