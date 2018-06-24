//
//  WKViewController.swift
//  WelcomeKitExample
//
//  Created by Josh Marasigan on 5/27/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class WKViewController: UIViewController {
    
    // MARK: - Properties
    private var paddingBetween: Int?
    private var animationViewHeight: Int?
    private var animationViewWidth: Int?
    
    // MARK: - Animation File (JSON) and properties
    private var animationView: LOTAnimationView!
    private var evenAnimationTimePartition: CGFloat!
    private var customAnimationTimePartitions: [CGFloat]? = [CGFloat]()
    
    // MARK: - Page Content Components
    private var pageViews: [WKPageView]!
    private lazy var pageContentView: WKPageContentView = {
        let contentView = WKPageContentView(
            pages: self.pageViews,
            delegate: self,
            pageControlColor: UIColor.white)
        return contentView
    }()
    
    private lazy var contentView: UIView = { return UIView() }()
    private var currentPage = 0
    
    /// WKViewController is a UIViewController class that displays a set amount of content views (WKPageViews)
    /// with an animationView (LOTAnimationView).
    /// - Parameters:
    ///   - pageViews: WKPageViews to be displayed by our controller
    ///   - animationView: Animation file exported from Adobe AE
    ///   - evenAnimationTimePartition: Animation progrss level for every swipe
    ///   - customAnimationTimePartitions: Array of animation progress level with each index correlating to a page
    ///   - paddingBetween: Optional padding between the animationView and the pageViews
    ///   - animationViewHeight: Optional animationView height
    ///   - animationViewWidth: Optional animationView width
    init(
         pageViews: [WKPageView],
         animationView: LOTAnimationView,
         evenAnimationTimePartition: CGFloat,
         
         customAnimationTimePartitions: [CGFloat]? = nil,
         paddingBetween: Int? = nil,
         animationViewHeight: Int? = nil,
         animationViewWidth: Int? = nil)
    {
        // Set pages to be seen in our onboarding flow
        self.pageViews = pageViews
        
        // Set padding between the animated view and animation if indicated
        self.paddingBetween = paddingBetween
        
        // Animation view optional dimentions
        self.animationViewHeight = animationViewHeight
        self.animationViewWidth = animationViewWidth
        
        // Animation partition times
        self.evenAnimationTimePartition = evenAnimationTimePartition
        self.customAnimationTimePartitions = customAnimationTimePartitions
        
        // Optional resize of the animation file to fit its content
        self.animationView = animationView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()

        // First animation partition
        self.animationView.play(
            toProgress: self.evenAnimationTimePartition,
            withCompletion: nil)
    }
    
    // MARK: - UI
    private func configUI() {
        // Container View for pageviews and animationView w/ optional padding
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // Add our LOTAnimationView instance to the view hierarchy
        self.contentView.addSubview(self.animationView)
        self.animationView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            
            // If size values were provided, set the animation view to those sizes
            if let animationViewHeight = self.animationViewHeight {
                make.height.equalTo(animationViewHeight)
            }
            if let animationViewWidth = self.animationViewWidth {
                make.width.equalTo(animationViewWidth)
            }
        }
        
        // Display your pageContentView by adding it to the super view
        self.contentView.addSubview(self.pageContentView.view)
        self.pageContentView.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.animationView.snp.bottom).offset(paddingBetween ?? 0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - WKPageContentViewDelegate
// These delegate calls enables the WKViewController class to know which
// animation progress time stamp to animate to next (these time stamps are from 0 to 1)
extension WKViewController: WKPageContentViewDelegate {
    
    // Animate to next time partition according to new page index
    func onNewPage(newPageIndex: Int) {
        
        // Get current animation time progress
        let currentProgress = self.evenAnimationTimePartition * CGFloat(self.currentPage + 1)
        
        // Calculate next animation time progress
        let newProgress = self.currentPage < newPageIndex ?
                self.evenAnimationTimePartition * CGFloat((newPageIndex + 1)) :
                self.evenAnimationTimePartition * CGFloat(self.currentPage)
        
        // Stop animating if end of animation is reached
        if !(0.0...1.0 ~= newProgress) { return }
        
        // Animate from current animation progress to new
        self.animationView.play(
            fromProgress: currentProgress,
            toProgress: newProgress,
            withCompletion: nil)
        
        self.currentPage = newPageIndex
    }
}
