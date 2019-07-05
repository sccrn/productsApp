//
//  HomeCoordinator.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-29.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

protocol HomeCDelegate: class {
    func moveToPaymentFlow(_ coordinator: HomeCoordinator, cart: CartRealm)
}

class HomeCoordinator: Coordinator {
    weak var delegate: HomeCDelegate?
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
        homeController.viewModel.coordinator = self
        navigationController.pushViewController(homeController, animated: false)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func moveForwardFlow(_ controller: HomeController, didSelect cart: CartRealm) {
        let viewModel = CheckoutViewModel(cart: cart)
        viewModel.coordinator = self
        let checkout = CheckoutController(viewModel: viewModel)
        navigationController.pushViewController(checkout, animated: true)
    }
}

extension HomeCoordinator: CheckoutCoordinatorDelegate {
    func didEndPayment(_ controller: CheckoutController, didSelect action: CheckoutAction) {
        switch action {
        case .dismiss: navigationController.popViewController(animated: true)
        case .checkout(let cart): delegate?.moveToPaymentFlow(self, cart: cart)
        }
    }
}
