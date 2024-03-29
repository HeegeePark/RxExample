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

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        let items = Observable.just(
            (0..<20).map { String($0) }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .bind(with: self) { owner, value in
                owner.showAlert(title: "RxExample",
                                message: "Tapped \(value)",
                                ok: "OK",
                                handler: { })
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .bind(with: self) { owner, indexPath in
                owner.showAlert(title: "RxExample",
                                message: "Tapped Detail @ \(indexPath.section),\(indexPath.row)",
                                ok: "OK",
                                handler: { })
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
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
