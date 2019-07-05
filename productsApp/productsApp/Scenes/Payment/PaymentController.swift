//
//  PaymentController.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-04.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class PaymentController: BaseController {
    private var viewModel: PaymentViewModel
    
    init(viewModel: PaymentViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout()
    }
    
    private func loadLayout() {
        viewModel.sendOrderCart()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.viewModel.coordinator?.moveForwardToHome(self)
        })
    }
}
