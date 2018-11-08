
import Foundation
import UIKit
public class QRCodeMaker: UIViewController {
    var stringValue: String? = nil
    private var qrcodeImageView: UIImageView!
    public override func viewDidLoad() {
        super.viewDidLoad()
//        setupNav()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        qrcodeImageViewSetup()
    }
    
    // MARK: - MAKE QRcode
    private func qrcodeImageViewSetup() {
        guard let value = stringValue?.data(using: .isoLatin1, allowLossyConversion: false) else { return }
        let filter = CIFilter(name: "CIQRCodeGenerator") // create QRCode濾鏡
        filter?.setValue(value, forKey: "inputMessage") // ValueType: Data
        filter?.setValue("Q", forKey: "inputCorrectionLevel") // QRCode Level: L=7%, M=15%, Q=25, H=30
        let resizeCIImage = qecodeImageResize(ciImage: (filter?.outputImage)!)
        qrcodeImageView = UIImageView(image: UIImage(ciImage: resizeCIImage))
        qrcodeImageView.frame.size = CGSize(width: 300, height: 300)
        qrcodeImageView.center = view.center
        self.view.addSubview(qrcodeImageView)
    }
    
    func qecodeImageResize(ciImage: CIImage) -> CIImage {
        let scaleX = 300 / ciImage.extent.width
        let scaleY = 300 / ciImage.extent.height
        let transformedImage = ciImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        return transformedImage
    }
    
    
    
    // MARK: - NavigationController setting
    private func setupNav() {
        self.title = "QRCode"
        self.navigationController?.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(backBtnPressed))
    }
    
    
    @objc private func backBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
