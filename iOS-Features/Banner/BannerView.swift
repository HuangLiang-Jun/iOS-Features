//
//  BannerView.swift
//  iOS-Features
//
//  Created by HuangLiangJun on 2018/11/2.
//

import Foundation
import UIKit

class BannerView: UIView, UIScrollViewDelegate {
    
    enum Derect {
        case left
        case right
        case none
    }
    
    
    private var images: [UIImage] = []
    private var derect: Derect = .none
    private var currentIndex = 0
    private var nextIndex = 1
    private var currentImageView: UIImageView?
    private var nextImageView: UIImageView?
    
    private var interval: TimeInterval = 3.0
    private var animationTimer: Timer?
    
    private var scrollView: UIScrollView?
    private var pageControl: UIPageControl?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(images: [UIImage]) {
        super.init(frame: .zero)
        self.images = images
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        self.setup()
    }
    
    
    private func setup() {
        if scrollView == nil {
            scrollView = UIScrollView()
            scrollView?.bounces = false
            scrollView?.showsVerticalScrollIndicator = false
            scrollView?.showsHorizontalScrollIndicator = false
            scrollView?.isPagingEnabled = true
            self.addSubview(scrollView!)
            
            scrollView?.anchorToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
            let index = images.count == 2 ? 3 : images.count
            scrollView?.contentSize.width = self.superview!.frame.width * CGFloat(index)
            scrollView?.delegate = self
        }
        
        if nextImageView == nil {
            nextImageView = UIImageView(frame: bounds)
            scrollView?.addSubview(nextImageView!)
        }
        
        nextImageView?.isUserInteractionEnabled = true
        nextImageView?.contentMode = .scaleToFill
        nextImageView?.clipsToBounds = true
        
        if currentImageView == nil {
            currentImageView = UIImageView(frame: bounds)
            scrollView?.addSubview(currentImageView!)
        }
        
        currentImageView?.isUserInteractionEnabled = true
        currentImageView?.contentMode = .scaleToFill
        currentImageView?.clipsToBounds = true
        currentImageView?.frame = CGRect(x: bounds.width,
                                         y: 0,
                                         width: bounds.width,
                                         height: bounds.height)
        
    
        scrollView?.contentOffset = CGPoint(x: bounds.size.width,y: 0)
        setImage(to: currentImageView, index: currentIndex)
        if images.count <= 0 { return }
        if pageControl == nil {
            
            pageControl = UIPageControl()
            pageControl?.currentPageIndicatorTintColor = .red
            pageControl?.pageIndicatorTintColor = .white
            pageControl?.numberOfPages = images.count
            addSubview(pageControl!)
            pageControl?.anchorCenter(top: nil,
                                      left: nil,
                                      bottom: bottomAnchor,
                                      right: nil,
                                      topConstant: 0,
                                      leftConstant: 0,
                                      bottomConstant: 20,
                                      rightConstant: 0,
                                      widthConstant: 80,
                                      heightConstant: 20,
                                      centerX: centerXAnchor)
            
            
        }
        
        timerStart()
    }
    
    
    // MARK: - set image
    func setImage(to imageView: UIImageView?, index: Int) {
        imageView?.image = nil
        imageView?.image = images[index]
    }
    
    
    private func reloadImage() {
        derect = .none
        
        let didScroll = (scrollView!.contentOffset.x / scrollView!.bounds.width) != 1
        
        if !didScroll { return }
        
        currentIndex = nextIndex
        
        currentImageView?.frame = CGRect(x: scrollView!.bounds.size.width,
                                         y: 0,
                                         width: scrollView!.bounds.size.width,
                                         height: scrollView!.bounds.size.height)
        
        currentImageView?.image = self.nextImageView!.image
        
        scrollView?.contentOffset = CGPoint(x: scrollView!.bounds.size.width,
                                            y: 0)
        
        pageControl?.currentPage = currentIndex
        
    }
    
    // MARK: - Timer
    private func timerStart() {
        if images.count <= 1 { return }
        
        if animationTimer != nil && animationTimer!.isValid { return }
        
        animationTimer = Timer.scheduledTimer(timeInterval: interval,
                                              target: self,
                                              selector: #selector(scrollBanner),
                                              userInfo: nil,
                                              repeats: true)
    
    }
    
    @objc private func scrollBanner() {
        
        let x = scrollView!.bounds.width * 2
        
        let point = CGPoint(x: x, y: 0)
        
        self.scrollView?.setContentOffset(point, animated: true)
    
    }
    
    func stopTimer() {
        animationTimer?.invalidate()
    }
    
    
    // MARK:- UIScrollView delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
        self.derect = scrollView.contentOffset.x > scrollView.bounds.width ? .left : .right // 滑動方向
        
        switch derect {
        
        case .left:
            
            self.nextImageView?.frame = CGRect(x: currentImageView!.frame.maxX,
                                               y: 0,
                                               width: scrollView.bounds.width,
                                               height: scrollView.bounds.height)
            
            nextIndex = (currentIndex + 1) % images.count
        
        case .right:
            
            nextImageView?.frame = CGRect(x: 0,
                                          y: 0,
                                          width: scrollView.bounds.width,
                                          height: scrollView.bounds.height)
            
            nextIndex = currentIndex - 1
           
            if nextIndex < 0 {
               
                nextIndex = images.count - 1
           
            }
       
        case .none: break
        
        }
        
        
        setImage(to: nextImageView, index: nextIndex)
        
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timerStart()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImage()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reloadImage()
    }
}

