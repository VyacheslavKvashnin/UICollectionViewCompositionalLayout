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
        let advancedVC = AdvancedViewController()
        
        viewControllers = [
            generateNavigationController(rootViewController: compositionalVC, title: "Compositional", image: UIImage(systemName: "desktopcomputer")!),
            generateNavigationController(rootViewController: listVC, title: "List", image: UIImage(systemName: "list.bullet.rectangle.portrait")!),
            generateNavigationController(rootViewController: advancedVC, title: "Advanced", image: UIImage(systemName: "graduationcap")!)
        ]
        
        
        
    }
  
    func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
