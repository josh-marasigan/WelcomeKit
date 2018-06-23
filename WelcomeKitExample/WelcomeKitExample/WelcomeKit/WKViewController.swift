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
    private var primaryColor = UIColor.white
    private var secondaryColor: UIColor?
    private var gradientBackgroundColor = CAGradientLayer()
    private var paddingBetween: Int?
    private var animationViewHeight: Int?
    private var animationViewWidth: Int?
    private var sideContentPadding: Int?
    private var verticalContentPadding: Int?
    
    // MARK: - Animation File (JSON)
    fileprivate var animationView: LOTAnimationView!
    
    // MARK: - Page Content Components
    fileprivate var pageViews = [WKPageView]()
    fileprivate lazy var pageContentView: WKPageContentView = {
        let contentView = WKPageContentView(
            pages: self.pageViews,
            delegate: self,
            pageControlColor: UIColor.white)
        return contentView
    }()
    
    // MARK: - Init
    /// WKViewController is a UIViewController class that displays a set amount of content views (WKPageViews)
    /// with an animationView (LOTAnimationView).
    ///
    /// - Parameters:
    ///   - primaryColor: Leading color for the background gradient. Defaults to white.
    ///   - secondaryColor: Trailing color for the background gradient. Defaults to nil.
    ///   - pageViews: The WKPageView(s) to be displayed
    ///   - animationView: The LOTAnimationView to be display along with the pageViews
    ///   - paddingBetween: Optional Int value for padding between pageViews and animationView
    ///   - animationViewHeight: Optional Int value to indicate the animationView's height
    ///   - animationViewWidth: Optional Int value to indicate the animationView's width
    ///   - sideContentPadding: Optional Int value indicating main view's horizontal padding
    ///   - verticalContentPadding: Optional Int value indicating main view's vertical padding
    ///   - animationViewContentMode: Optional ContentMode enum for animationView's contentMode
    init(primaryColor: UIColor,
         secondaryColor: UIColor?,
         pageViews: [WKPageView],
         animationView: LOTAnimationView,
         paddingBetween: Int? = nil,
         animationViewHeight: Int? = nil,
         animationViewWidth: Int? = nil,
         sideContentPadding: Int? = nil,
         verticalContentPadding: Int? = nil,
         animationViewContentMode: UIView.ContentMode? = nil)
    {
        // Set solid color or color gradient for our WKViewController's background
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        
        // Set pages to be seen in our onboarding flow
        self.pageViews = pageViews
        
        // Set padding between the animated view and animation if indicated
        self.paddingBetween = paddingBetween
        
        // Animation view optional dimentions
        self.animationViewHeight = animationViewHeight
        self.animationViewWidth = animationViewWidth
        
        // Set padding for the main content view if indicated
        self.sideContentPadding = sideContentPadding
        self.verticalContentPadding = verticalContentPadding
        
        // Size animation file to fit its content
        self.animationView = animationView
        self.animationView.contentMode = animationViewContentMode ?? .scaleAspectFit
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        
        self.animationView.play{ (finished) in
            print("Done Animating")
        }
    }
    
    // MARK: - UI
    private func configUI() {
        self.setBackgroundColor()
        
        // Container View for pageviews and animationView w/ optional padding
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.sideContentPadding ?? 0)
            make.trailing.equalToSuperview().offset(-(self.sideContentPadding ?? 0))
            make.top.equalToSuperview().offset(self.verticalContentPadding ?? 0)
            make.bottom.equalToSuperview().offset(-(self.verticalContentPadding ?? 0))
        }
        
        // Add our LOTAnimationView instance to the view hierarchy
        contentView.addSubview(animationView)
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
        contentView.addSubview(self.pageContentView.view)
        self.pageContentView.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.animationView.snp.bottom).offset(paddingBetween ?? 0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // Set the background color to your desired gradient
    private func setBackgroundColor() {
        // If only one color (primaryColor) was set, no gradient will be applied
        guard let secondaryColor = self.secondaryColor else {
            self.view.backgroundColor = self.primaryColor
            return
        }
        
        // Set gradient properties and clip to bounds
        self.gradientBackgroundColor.frame = self.view.bounds
        self.gradientBackgroundColor.colors = [primaryColor.cgColor, secondaryColor.cgColor]
        self.gradientBackgroundColor.startPoint = CGPoint(x: 1, y: 1)
        self.gradientBackgroundColor.endPoint = CGPoint(x: 1, y: 0)
        self.view.layer.addSublayer(self.gradientBackgroundColor)
    }
}

// MARK: - WKPageContentViewDelegate
extension WKViewController: WKPageContentViewDelegate {
    func onNextPage(pageIndex: Int) {
        print("Current Index: \(pageIndex)")
    }
    
    func onPreviousPage(pageIndex: Int) {
        print("Current Index: \(pageIndex)")
    }
}
