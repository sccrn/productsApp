//
//  PaymentCoordinator.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-04.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

protocol PaymentCDelegate: class {
    func moveToHomeFlow(_ coordinator: PaymentCoordinator)
}

class PaymentCoordinator: Coordinator {
    weak var delegate: PaymentCDelegate?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return navigationController }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()
    
    func start(cart: CartRealm) {
        let viewModel = PaymentViewModel(cart: cart)
        viewModel.coordinator = self
        let payment = PaymentController(viewModel: viewModel)
        navigationController.viewControllers.append(payment)
    }
}

extension PaymentCoordinator: PaymentVMCoordinatorDelegate {
    func moveForwardToHome(_ controller: PaymentController) {
        delegate?.moveToHomeFlow(self)
    }
}
