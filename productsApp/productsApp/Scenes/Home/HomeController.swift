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
                return cell
            case .product(let product):
                let cell = tableView.dequeue(cellClass: ProductCell.self, indexPath: indexPath)
                cell.configure(product: product)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadProducts()
    }
    
    private func loadNavBar() {
        navigationItem.title = Constants.Screen.home
    }
    
    private func loadLayout() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.registerNib(cellClass: CartCell.self)
        tableView.registerNib(cellClass: ProductCell.self)
        
        viewModel.productsObservable.flatMap { (products) -> Observable<[ProductSection]> in  return .just(self.viewModel.updateTableView(by: products))
        }.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
}
