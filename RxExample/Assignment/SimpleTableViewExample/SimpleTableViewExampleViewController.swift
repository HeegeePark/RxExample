//
//  SimpleTableViewExampleViewController.swift
//  RxExample
//
//  Created by 박희지 on 3/29/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimpleTableViewExampleViewController: BaseViewController {
    private let tableView = UITableView()
    private let viewModel = SimpleTableViewExampleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        tableView.rx.itemAccessoryButtonTapped
            .bind(to: viewModel.itemAccessoryButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.showAlert
            .bind { [weak self] alert in
                self?.showAlert(title: alert.title, message: alert.message, ok: alert.ok, handler: alert.handler)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
