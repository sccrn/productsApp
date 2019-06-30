//
//  HomeCoordinator.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-29.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return navigationController }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = .navBar
        navigationController.navigationBar.tintColor = .navTintColor
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.navTintColor]
        return navigationController
    }()
    
    func start() {
        let homeController = HomeController()
        homeController.viewModel = HomeViewModel()
        navigationController.pushViewController(homeController, animated: false)
    }
}
