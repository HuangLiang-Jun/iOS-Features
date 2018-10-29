//
//  HLBannerTableViewCell.swift
//  iOS-Features
//
//
//  Created by HuangLiangJun on 2018/10/29.
//

import UIKit

class EasyBannerTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let collection_cell_id = "cv_cell"
    var timer: Timer?
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width,
                                 height: EasyBannerViewController.cell_height)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(EasyBannerCollectionViewCell.self, forCellWithReuseIdentifier: collection_cell_id)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        cv.isPagingEnabled = true // 照片一張一張播的效果
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    // MARK: - setup
    private var images: [UIImage] = []
   
    func setup(images: [UIImage]) {
        self.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.separatorInset = .zero
        self.selectionStyle = .none
        self.images = images
        handleCollectionView()
        startTimer()
    }
    
    func handleCollectionView() {
        addSubview(collectionView)
        collectionView.anchorToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    // MARK: - Timer Control
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func autoScroll() {
        let width = frame.size.width
        
        let offset = self.collectionView.contentOffset.x
        
        let _index: Int = Int(offset) / Int(width)
        
        let nextRow = _index + 1
        
        let next = nextRow == self.images.count ? 0 : nextRow
        
        startToScroll(to: next)

    }
    
    private func startToScroll(to row: Int) {
        let indexPath = IndexPath(item: row, section: 0)
        self.collectionView.scrollToItem(at: indexPath,
                                         at: .centeredHorizontally,
                                         animated: row != 0)
    }
    
    
    // MARK: - CollectionView delegate and datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collection_cell_id, for: indexPath) as! EasyBannerCollectionViewCell
        cell.setup(image: images[indexPath.item])
        return cell
    }
    
    
    // MARK: - ScrollView delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
}
