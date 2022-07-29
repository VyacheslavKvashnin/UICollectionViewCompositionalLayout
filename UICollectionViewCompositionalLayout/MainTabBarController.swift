//
//  MainTabBarController.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Вячеслав Квашнин on 29.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listVC = ListViewController()
        let compositionalVC = CompositionalViewController()
        
        viewControllers = [
            generateNavigationController(rootViewController: listVC, title: "List", image: UIImage(systemName: "list.bullet.rectangle.portrait")!),
            generateNavigationController(rootViewController: compositionalVC, title: "Compositional", image: UIImage(systemName: "desktopcomputer")!)
        ]
        
        
        
    }
  
    func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
