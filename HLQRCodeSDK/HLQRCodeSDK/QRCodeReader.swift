
import Foundation
import UIKit
import AVFoundation

@objc public protocol QRCodeReaderDelegate {
   @objc func metadata(stringValue: String?) // 掃到的字串自葛到外面解
}

public class QRCodeReader: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @objc public var delegate: QRCodeReaderDelegate? = nil
    
    private var captureSession: AVCaptureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var qrcodeFrameView: UIView?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
//        setupNav()
        self.startScan()
    }
   
    
    private func setupNav() {
        
        self.title = "掃描QRCode"
        self.navigationController?.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(backBtnPressed))
    }


    @objc private func backBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }

    
    deinit {
        print("QRCodeReader deinit.")
        self.delegate = nil
    }
    
    private func startScan() {
       self.confirmAuthorizationStatus()
    }
    
    private func confirmAuthorizationStatus() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authorizationStatus {
        case .notDetermined:
            if authorizationStatus == .notDetermined { // 相機未授權
                AVCaptureDevice.requestAccess(for: .video) { (granted) in
                    self.confirmAuthorizationStatus()
                }
            }
        case .restricted,
             .denied: // TODO: - show alert and dismiss viewcontroller
            print("authorization status: \(authorizationStatus)")
        case .authorized: // 已授權
            print("camera 已授權")
            self.setupCapture()
        }
    }
    
    private func setupCapture() {
        
        let device = AVCaptureDevice.default(for: .video)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: device!)
        } catch {
            print("video input fail: \(error.localizedDescription)")
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
            startRunning()
        } else {
            print("can not add input")
            return
        }

    }
    
    private func startRunning() {
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                let captureMetadataOutput = AVCaptureMetadataOutput()
                if self.captureSession.canAddOutput(captureMetadataOutput) {
                    self.captureSession.addOutput(captureMetadataOutput)
                    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                    captureMetadataOutput.metadataObjectTypes = [.qr]
                    self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                    self.videoPreviewLayer.frame = self.view.layer.bounds
                    self.videoPreviewLayer.videoGravity = .resizeAspectFill
                    self.view.layer.addSublayer(self.videoPreviewLayer)
                    self.setupQrCodeFrameView()
                    self.captureSession.startRunning()
                    
                } else {
                    print("can not add output.")
                }
            }
           
        }
    }
    
    
    private func setupQrCodeFrameView() {
        print("setupQrCodeFrameView")
        qrcodeFrameView = UIView()
        qrcodeFrameView?.layer.borderColor = UIColor.green.cgColor
        qrcodeFrameView?.layer.borderWidth = 2
        qrcodeFrameView?.frame.size = CGSize(width: 200, height: 200)
        qrcodeFrameView?.center = view.center
        view.addSubview(qrcodeFrameView!)
        view.bringSubviewToFront(qrcodeFrameView!)
        
    }
    
    
    
    public override var prefersStatusBarHidden: Bool {
        return false
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
  
    //MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print("metadataOutput")
        if metadataObjects.count == 0 { return }
        print("found the qrcode.")
        if let metaObj = videoPreviewLayer.transformedMetadataObject(for: metadataObjects.first!), let readablObj = metaObj as? AVMetadataMachineReadableCodeObject { // 轉換成可讀資料
            if qrcodeFrameView!.frame.contains(metaObj.bounds) {
                
                captureSession.stopRunning()
                delegate?.metadata(stringValue: readablObj.stringValue)
                
                if self.navigationController == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            } else { /* QRCode outside of frameView */}
        }
    }
}
