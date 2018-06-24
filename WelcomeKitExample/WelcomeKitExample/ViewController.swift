//
//  ViewController.swift
//  WelcomeKitExample
//
//  Created by Josh Marasigan on 5/24/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import UIKit
import SnapKit
import WelcomeKit
import Lottie

class ViewController: UIViewController {

    // MARK: - Properties
    private var welcomeVC: WKViewController!
    private var pageViews: [WKPageView]!
    private var mainAnimationView: LOTAnimationView!
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    // MARK: - UI
    private func configUI() {
        self.setBackgroundColor()
        
        // Create LOTAnimationView instance and set configurations
        self.mainAnimationView = LOTAnimationView(name: "servishero_loading")
        self.mainAnimationView.animationSpeed = 0.5
        self.mainAnimationView.contentMode = .scaleAspectFit
        
        // Instantiate the page views to be displayed
        self.pageViews = configPageViews()
        
        // Instantiating a WKViewController
        self.welcomeVC = WKViewController(
            pageViews: pageViews,
            animationView: mainAnimationView,
            evenAnimationTimePartition: 0.118
        )
        
        // Auto Layout
        self.view.addSubview(self.welcomeVC.view)
        self.welcomeVC.view.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(32)
            make.bottom.trailing.equalToSuperview().offset(-32)
        }
    }
    
    // Set WKPageView(s) and their View Model instances
    private func configPageViews() -> [WKPageView] {
        var pages = [WKPageView]()
        
        let firstPageViewModel = WKPageViewModel(
            title: "First Title",
            description: "This is the first page in our welcome pages.")
        let firstPage = WKPageView(viewModel: firstPageViewModel)
        
        let secondPageViewModel = WKPageViewModel(
            title: "Next Title",
            description: "This is the middle page in our welcome pages.")
        let secondPage = WKPageView(viewModel: secondPageViewModel)
        
        let lastPageViewModel = WKPageViewModel(
            title: "Last Title",
            description: "You've reached the end of our onboarding screens.")
        let lastPage = WKPageView(viewModel: lastPageViewModel)
        
        // You can also edit WKPageView's UILabel properties for styling
        firstPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        firstPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        secondPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        secondPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)

        lastPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        lastPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(lastPage)
        return pages
    }
    
    private func setBackgroundColor() {
        // Set gradient properties and clip to bounds
        let primaryColor = UIColor(red:1.00, green:0.60, blue:0.62, alpha:1.0)
        let secondaryColor = UIColor(red:0.98, green:0.82, blue:0.77, alpha:1.0)
        
        let gradientBackgroundColor = CAGradientLayer()
        gradientBackgroundColor.frame = self.view.bounds
        gradientBackgroundColor.colors = [primaryColor.cgColor, secondaryColor.cgColor]
        gradientBackgroundColor.startPoint = CGPoint(x: 1, y: 1)
        gradientBackgroundColor.endPoint = CGPoint(x: 1, y: 0)
        self.view.layer.addSublayer(gradientBackgroundColor)
    }
}

