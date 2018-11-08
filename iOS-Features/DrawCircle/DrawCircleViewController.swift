//
//  DrawCircleViewController.swift
//  iOS-Features
//
//  Created by liangJun on 2018/11/8.
//

import UIKit

class DrawCircleViewController: UIViewController {
    var progressView = CircleView()
    @IBOutlet weak var circleContentView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
   
    
    @IBAction func slideVIewPressed(_ sender: UISlider) {
        
        let val = CGFloat(sender.value) / 100
        self.progressView.progress = val
    }
    
    
    func setup() {
        
        circleContentView.addSubview(progressView)
        progressView.anchorWithConstantsToTop(circleContentView.topAnchor, left: circleContentView.leftAnchor, bottom: circleContentView.bottomAnchor, right: circleContentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }


}
