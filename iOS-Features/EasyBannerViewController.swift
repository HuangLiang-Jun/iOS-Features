//
//  BannerViewController.swift
//  iOS-Features
//
//  Created by HuangLiangJun on 2018/10/29.
//

import UIKit

class EasyBannerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let cell_id = "cell"
    static let cell_height: CGFloat = 200.0
    let images: [UIImage] = [#imageLiteral(resourceName: "book_img"), #imageLiteral(resourceName: "mac_img"), #imageLiteral(resourceName: "cup_img"), #imageLiteral(resourceName: "house_img"), #imageLiteral(resourceName: "sea_img")]
    lazy var tableview: UITableView = {
        let tb = UITableView()
        tb.register(EasyBannerTableViewCell.self, forCellReuseIdentifier: cell_id)
        tb.delegate = self
        tb.dataSource = self
        tb.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        tb.tableFooterView = UIView()
        return tb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleTableView()
    }
    
    func handleTableView() {
        
        self.view.addSubview(tableview)
        self.tableview.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

    // MARK: - UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as! EasyBannerTableViewCell
        cell.setup(images: images)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EasyBannerViewController.cell_height
    }
}
