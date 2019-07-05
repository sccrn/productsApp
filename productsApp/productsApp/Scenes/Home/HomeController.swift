//
//  HomeController.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-29.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HomeController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<ProductSection> = {
       RxTableViewSectionedReloadDataSource<ProductSection>(
        configureCell: { dataSource, tableView, indexPath, item in
            switch dataSource[indexPath] {
            case .cart(let cart):
                let cell = tableView.dequeue(cellClass: CartCell.self, indexPath: indexPath)
                cell.configure(cart: cart)
                cell.delegate = self
                return cell
            case .product(let product, let cart):
                let cell = tableView.dequeue(cellClass: ProductCell.self, indexPath: indexPath)
                cell.configure(product: product, cart: cart)
                cell.addProductView.delegate = self
                return cell
            }
       })
    }()
    private var disposeBag = DisposeBag()
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout()
        loadNavBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    private func loadNavBar() {
        navigationItem.title = Constants.Screen.home
    }
    
    private func loadLayout() {
        viewModel.onShowLoadingHud.map { [weak self] in
            $0 == true ? self?.showLoading() : self?.stopLoading()
        }.subscribe().disposed(by: disposeBag)
        
        viewModel.onShowError.map { [weak self] in
            self?.showError(message: $0)
        }.subscribe().disposed(by: disposeBag)
        
        loadTableView()
    }
    
    private func loadTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.registerNib(cellClass: CartCell.self)
        tableView.registerNib(cellClass: ProductCell.self)
        
        viewModel.productsObservable.flatMap { (products) -> Observable<[ProductSection]> in  return .just(self.viewModel.updateTableView(by: products))
        }.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}

extension HomeController: CartCellDelegate {
    func didSelectCheckout(for cart: CartRealm) {
        if cart.products.count == 0 {
            showError(message: Constants.Error.zeroProducts)
        } else {
            viewModel.coordinator?.moveForwardFlow(self, didSelect: cart)
        }
    }
}

extension HomeController: PAddProductsDelegate {
    func didChangeQuantity(for product: ProductRealm, isAddProduct: Bool) {
        viewModel.saveProduct(product: product, isAddProduct: isAddProduct)
    }
}
