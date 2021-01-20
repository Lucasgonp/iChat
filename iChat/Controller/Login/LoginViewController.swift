//
//  LoginViewController.swift
//  iChat
//
//  Created by Lucas Pereira on 07/10/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = Font.fontTextBold(size: 28)
        label.textColor = Color.blue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialData()
    }
    
   private func initialData() {
    self.view.backgroundColor = Color.white
        
    self.view.addSubview(titleLabel)
        
    self.view.addConstraintsWithFormat(format: "H:|-8-[v0]", views: titleLabel)
    self.view.addConstraintsWithFormat(format: "V:|-26-[v0]", views: titleLabel)
    }
}
