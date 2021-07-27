//
//  ViewController.swift
//  Animation
//
//  Created by qiyu on 2021/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    var viewA: UIView!
    @IBOutlet var tableView: UITableView!
    var titles = [String]()
    let cellIdentifier = "cellreuseid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Animation"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        titles = ["Basic", "ViewController Transition"]
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = BasicViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "VCTViewController")
            if let viewController = vc {
                navigationController?.pushViewController(viewController, animated: true)
            }
        default:
            print("")
        }
    }
    

}

