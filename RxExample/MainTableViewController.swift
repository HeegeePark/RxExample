//
//  MainTableViewController.swift
//  RxExample
//
//  Created by 박희지 on 4/2/24.
//

import UIKit

final class MainTableViewController: UITableViewController {
    private let viewControllers = [SimpleTableViewExampleViewController.self,
                                   SimplePickerViewExampleViewController.self,
                                   NumbersViewController.self,
                                   SimpleValidationViewController.self]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let vcType = viewControllers[indexPath.row]
        cell.textLabel?.text = vcType.identifier
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcType = viewControllers[indexPath.row]
        let vc = vcType.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}
