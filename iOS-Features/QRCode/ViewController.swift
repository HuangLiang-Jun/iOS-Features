//
//  ViewController.swift
//  QRCodeReader
//
//  Created by HuangLiangJun on 2018/10/23.

import UIKit
import HLQRCodeSDK


class ViewController: UIViewController, QRCodeReaderDelegate {
    let ma = HLQRCodeManager()
    @IBOutlet weak var QRCodeMsgLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.debug("test")
        Logger.error("error")
        Logger.info("info")
        
      self.navigationController?.view.backgroundColor = .white
    }
  
 
    
    @IBAction func scanQRcodeBtnPressed(_ sender: Any) {
        let vc = ma.qrcodeReader(delegate: self)
        vc.view.backgroundColor = .white
        self.show(vc, sender: nil)
    }
    
    
 
    @IBAction func makeQRCodeBtnPressed(_ sender: Any) {
        let vc = ma.qrcodeMaker(stringValue: "哈囉喔")
        vc.view.backgroundColor = .white
        self.show(vc, sender: nil)

    }
    
    
    
    func metadata(stringValue: String?) {
        if let val = stringValue {
            QRCodeMsgLabel.text = val
        }
    }
    
    
}

