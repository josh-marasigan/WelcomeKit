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
        // WKViewController Parameter Instances
        let primaryColor = UIColor(red:1.00, green:0.60, blue:0.62, alpha:1.0)
        let secondaryColor = UIColor(red:0.98, green:0.82, blue:0.77, alpha:1.0)
        let mainAnimationView = LOTAnimationView(name: "servishero_loading")
        
        // Instantiate the page views to be displayed
        let pageViews = configPageViews()
        
        // Instantiating a WKViewController
        let welcomeVC = WKViewController(
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            pageViews: pageViews,
            animationView: mainAnimationView
        )
        
        // Auto Layout
        self.view.addSubview(welcomeVC.view)
        welcomeVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // Set WKPageView(s) and their View Model instances
    private func configPageViews() -> [WKPageView] {
        var pages = [WKPageView]()
        
        // First Page
        let firstPageDescription =
        """
        This is the first page in our welcome pages. The animation should have started to perform its animation.

        If an animation progression was indicated, this animation should not have gone past the designated animation progression value (these are from 0 to 1).
        """
        let firstPageViewModel = WKPageViewModel(title: "First Title", description: firstPageDescription)
        let firstPage = WKPageView(viewModel: firstPageViewModel)
        
        // Second Page
        let secondPageDescription =
        """
        This is the middle page in our welcome pages. Swipe left or right and to see our animation play in their designated start times.
        """
        let secondPageViewModel = WKPageViewModel(title: "Second Title",description: secondPageDescription)
        let secondPage = WKPageView(viewModel: secondPageViewModel)
        
        // Last Page
        let thirdPageDescription =
        """
        You've reached the end of our onboarding screens, feel free to add more.
        As you can see, we can arbitrarily append pages. Just be sure to configure animation speed accordingly.
        """
        let thirdPageViewModel = WKPageViewModel(title: "Last Title", description: thirdPageDescription)
        let thirdPage = WKPageView(viewModel: thirdPageViewModel)
        
        // Set pages to view controller list, track via 'pages' array
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(thirdPage)
        return pages
    }
}

