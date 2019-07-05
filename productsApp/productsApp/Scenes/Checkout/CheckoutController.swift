//
//  CheckoutController.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-03.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CheckoutController: BaseController {
    @IBOutlet weak var tableView: UITableView!
 
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<CheckoutSection> = {
        RxTableViewSectionedReloadDataSource<CheckoutSection>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch dataSource[indexPath] {
                case .details(let cart):
                    let cell = tableView.dequeue(cellClass: CheckoutCell.self, indexPath: indexPath)
                    cell.configure(total: cart.price)
                    cell.payButton.rx.tap.asDriver()
                        .drive(onNext: { [weak self] in
                            guard let self = self else { return }
                            self.viewModel.coordinator?.didEndPayment(self, didSelect: .checkout(cart: self.viewModel.cart))
                        }).disposed(by: cell.disposedCell)
                    return cell
                case .discountDetails(let discount):
                    let cell = tableView.dequeue(cellClass: DiscountCell.self, indexPath: indexPath)
                    cell.configure(discount: discount)
                    return cell
                case .productDetails(let product, let isLastItem):
                    let cell = tableView.dequeue(cellClass: BuyProductCell.self, indexPath: indexPath)
                    cell.configure(product: product, isLastItem: isLastItem)
                    return cell
                }
        })
    }()
    private var disposeBag = DisposeBag()
    var viewModel: CheckoutViewModel
    
    init(viewModel: CheckoutViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNavBar()
        loadLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    private func loadNavBar() {
        navigationItem.title = Constants.Screen.checkout
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(actionBackButton))
    }
    
    @objc private func actionBackButton() {
        viewModel.coordinator?.didEndPayment(self, didSelect: .dismiss)
    }
    
    private func loadLayout() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.registerNib(cellClass: CheckoutCell.self)
        tableView.registerNib(cellClass: DiscountCell.self)
        tableView.registerNib(cellClass: BuyProductCell.self)
        
        viewModel.productsObservable.flatMap { (products) -> Observable<[CheckoutSection]> in
            return .just(self.viewModel.updateTableView(by: products))
        }.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}

extension CheckoutController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .cartSection: return 0
        case .discountSection: return 30
        case .productSection: return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
