//
//  MainViewController.swift
//  QRCodeReader
//
//  Created by HuangLiangJun on 2018/10/23.
//

import UIKit





class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Feature {
        
        let displayName: String
        let segueID: String
        
        init(displayName: String, segueID: String) {
            self.displayName = displayName
            self.segueID = segueID
        }
    }
    
    
    @IBOutlet var mainTableView: UITableView!
    
    
    let features = [Feature(displayName: "QRCode", segueID: "QRCode"),
                    Feature(displayName: "Keychain", segueID: "Keychain"),
                    Feature(displayName: "CollectionView Banner", segueID: "CollectionViewBanner"),
                    Feature(displayName: "ScrollView Banner", segueID: "ScrollViewBanner"),
                    Feature(displayName: "Badge", segueID: "Badge")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.tableFooterView = UIView()
        
    }
    

    // MARK - table view datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.setup(title: features[indexPath.row].displayName)
        return cell
    }
    
    // MARK: - table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // scrollPosition***??
        performSegue(withIdentifier: features[indexPath.row].segueID, sender: nil)
    }
    
}
