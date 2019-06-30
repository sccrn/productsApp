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
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionProducts> = {
       RxTableViewSectionedReloadDataSource<SectionProducts>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeue(cellClass: HomeCell.self, indexPath: indexPath)
            return cell
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
        
    }
    
    private func loadNavBar() {
        navigationItem.title = Constants.Screen.home
    }
    
    private func loadLayout() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.registerNib(cellClass: HomeCell.self)
        
        viewModel.productsObservable.flatMap { (products) -> Observable<[SectionProducts]> in
            return .just([SectionProducts(items: products, header: Constants.Label.sectionTitle)])
        }.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}
