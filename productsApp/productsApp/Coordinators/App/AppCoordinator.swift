//
//  AppCoordinator.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-29.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return navigationController }

    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = .black
        return navigationController
    }()
    
    let window: UIWindow?
    
    public init(window: UIWindow?) {
        self.window = window
        self.window?.rootViewController = self.rootViewController
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        startHomeFlow()
    }
    
    private func startHomeFlow() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        homeCoordinator.delegate = self
        addChildCoordinator(homeCoordinator)
        rootViewController.present(homeCoordinator.rootViewController, animated: false, completion: nil)
    }
}

extension AppCoordinator: HomeCDelegate {
    func moveToPaymentFlow(_ coordinator: HomeCoordinator, cart: CartRealm) {
        coordinator.rootViewController.dismiss(animated: false)
        self.removeChildCoordinator(coordinator)
        
        let paymentCoordinator = PaymentCoordinator()
        paymentCoordinator.start(cart: cart)
        paymentCoordinator.delegate = self
        addChildCoordinator(paymentCoordinator)
        rootViewController.present(paymentCoordinator.rootViewController, animated: false, completion: nil)
    }
}

extension AppCoordinator: PaymentCDelegate {
    func moveToHomeFlow(_ coordinator: PaymentCoordinator) {
        coordinator.rootViewController.dismiss(animated: false)
        self.removeChildCoordinator(coordinator)
        
        startHomeFlow()
    }
}
