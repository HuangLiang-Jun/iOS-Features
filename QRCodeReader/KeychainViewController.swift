//
//  KeychainViewController
//  QRCodeReader
//
//  Created by HuangLiangJun on 2018/10/23.

import UIKit

class KeychainViewController: UIViewController {

    @IBOutlet weak var keychainItemLabel: UILabel!
    @IBOutlet weak var idfvLabel: UILabel!
    let key = "test-case"
    var idfv = ""
    let service: String = Bundle.main.bundleIdentifier ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createIDFV() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    @IBAction func retrieveKeychainBtnPressed(_ sender: Any) {
        let addquery: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecMatchLimit as String  : kSecMatchLimitOne,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecAttrService as String : self.service,
            kSecAttrAccount as String : key
        ]
        var result: CFTypeRef?
        
        let status = SecItemCopyMatching(addquery as CFDictionary, &result)
        if result == nil {
            print("result is nil.")
            return
        }
        let d = result as! Data
        let idfv = String(data: d, encoding: .utf8) ?? ""
        
        let message = """
                    success: \(status == errSecSuccess)
                    IDFV: \(idfv)
                    """
        self.keychainItemLabel.text = message
        print(message)
    }
    
    @IBAction func storeKeychainBtnPressed(_ sender: Any) {
        
        let addquery: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecAttrService as String : self.service,
            kSecValueData as String   : idfv.data(using: .utf8)!
        ]
        let status = SecItemAdd(addquery as CFDictionary, nil)
        
        guard status == errSecSuccess else { return }
        print("status: \(status)")
    }
    
    
    @IBAction func createIDFVBtnPressed(_ sender: Any) {
        idfv = createIDFV()
        idfvLabel.text = idfv
    }


}
