//
//  MainViewController.swift
//  QRCodeReader
//
//  Created by HuangLiangJun on 2018/10/23.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mainTableView: UITableView!
    let features = ["QRCode", "Keychain"]
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    

    // MARK - table view datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.setup(title: features[indexPath.row])
        return cell
    }
    
    // MARK: - table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none) // scrollPosition***??
        performSegue(withIdentifier: features[indexPath.row], sender: nil)
    }
    
}
