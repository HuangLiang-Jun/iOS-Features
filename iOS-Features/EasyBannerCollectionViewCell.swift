//
//  HLBannerCollectionViewCell.swift
//  iOS-Features
//
//
//  Created by HuangLiangJun on 2018/10/29.
//

import Foundation
import UIKit


class EasyBannerCollectionViewCell: UICollectionViewCell {
    
    var imgData: UIImage? {
        didSet {
            guard let img = imgData else { return }
            
            self.imageView.image = img
        }
    }
    var imageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleToFill
        return imv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    func setup(image: UIImage) {
    
        self.imgData = image
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
