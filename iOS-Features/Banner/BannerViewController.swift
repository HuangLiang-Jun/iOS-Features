//
//  BannerViewController.swift
//  iOS-Features
//
//  Created by HuangLiangJun on 2018/11/2.
//

import UIKit

class BannerViewController: UIViewController {
  
    @IBOutlet weak var bannerContentView: UIView!
    var banner: BannerView!
    let images: [UIImage] = [#imageLiteral(resourceName: "book_img"), #imageLiteral(resourceName: "mac_img"), #imageLiteral(resourceName: "cup_img"), #imageLiteral(resourceName: "house_img"), #imageLiteral(resourceName: "sea_img")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        banner = BannerView(images: images)
        bannerContentView.addSubview(banner)
        banner.anchorToTop(bannerContentView.topAnchor,
                      left: bannerContentView.leftAnchor,
                      bottom: bannerContentView.bottomAnchor,
                      right: bannerContentView.rightAnchor)
    
    }
    


}
