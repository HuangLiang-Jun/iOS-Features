//
//  HLQRCodeManager.swift
//  HLQRCodeSDK
//
//  Created by liangJun. on 2018/10/24.
//  Copyright © 2018 liangJun. All rights reserved.
//

import Foundation


public class HLQRCodeManager: NSObject {
    
    @objc public func qrcodeMaker(stringValue: String) -> QRCodeMaker {
        let vc = QRCodeMaker()
        vc.stringValue = stringValue
        return vc
    }
    
    @objc public func qrcodeReader(delegate: QRCodeReaderDelegate?) -> QRCodeReader {
        let vc = QRCodeReader()
        vc.delegate = delegate
        return vc
    }
 
}
