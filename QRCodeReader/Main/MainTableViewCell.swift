//
//  MainTableViewCell.swift
//  QRCodeReader
//
//  Created by HuangLiangJun on 2018/10/26.
//  Copyright © 2018 HuangLiangJun. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(title: String) {
        self.textLabel?.text = title
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }

}
