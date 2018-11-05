//
//  BadgeViewController.swift
//  iOS-Features
//
//  Created by liangJun on 2018/11/5.
//

import UIKit

class BadgeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBadge()

    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        let count = Int(sender.value)
        self.navigationItem.rightBarButtonItem?.updateBadge(number: count)
    }
    
    func setupBadge() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        btn.setImage(#imageLiteral(resourceName: "info"), for: .normal)
        let item = UIBarButtonItem()
        item.customView = btn
        item.updateBadge(number: 1)
        self.navigationItem.rightBarButtonItem = item
//        self.navigationItem.rightBarButtonItem?.updateBadge(number: 1)
    }
    
    
 

}
