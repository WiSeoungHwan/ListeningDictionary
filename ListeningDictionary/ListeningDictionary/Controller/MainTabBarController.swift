//
//  MainTabBarController.swift
//  ListeningDictionary
//
//  Created by Wi on 03/08/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: SearchViewController())]
    }

}
