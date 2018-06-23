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
    
    // MARK: - Parameters
    private var primaryColor = UIColor.white
    private var secondaryColor: UIColor?
    private var gradientBackgroundColor = CAGradientLayer()
    
    // MARK: - Properties
    private let sidePadding = 32
    private let verticalPadding = 32
    
    // MARK: - Animation File (JSON)
    fileprivate var animationView: LOTAnimationView!
    
    // MARK: - Page Content Components
    fileprivate var pageViews = [WKPageView]()
    fileprivate lazy var pageContentView: WKPageContentView = {
        let contentView = WKPageContentView(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            pages: self.pageViews,
            delegate: self)
        return contentView
    }()
    
    // MARK: - Init
    init(primaryColor: UIColor,
         secondaryColor: UIColor?,
         pageViews: [WKPageView],
         animationView: LOTAnimationView,
         animationViewHeight: Int? = nil,
         animationViewWidth: Int? = nil,
         animationViewContentMode: UIView.ContentMode? = nil)
    {
        // Set solid color or color gradient for our WKViewController's background
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        
        // Set pages to be seen in our onboarding flow
        self.pageViews = pageViews
        
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
        
        self.view.addSubview(animationView)
        self.animationView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
        
        // Display your pageContentView by adding it to the super view
        self.view.addSubview(self.pageContentView.view)
        self.pageContentView.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.animationView.snp.bottom).offset(verticalPadding)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(verticalPadding * 2))
        }
    }
    
    // Set the background color to your desired gradient
    // If only one color (primaryColor) was set, no gradient will be applied
    private func setBackgroundColor() {
        guard let secondaryColor = self.secondaryColor else {
            self.view.backgroundColor = self.primaryColor
            return
        }
        
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
