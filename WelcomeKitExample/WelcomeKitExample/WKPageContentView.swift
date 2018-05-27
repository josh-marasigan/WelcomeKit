//
//  WKPageContentView.swift
//  WelcomeKitExample
//
//  Created by Josh Marasigan on 5/27/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class WKPageContentView: UIPageViewController, UIPageViewControllerDataSource {
    // MARK: - Properties
    fileprivate var pages = [UIViewController]()
    fileprivate let pageControl = UIPageControl()
    fileprivate var pageStackCount = 0
    
    /* Replace with after effect animation */
    fileprivate var pageImage: UIImageView?
    
    // MARK: - Initializers
    override init(
        transitionStyle style: UIPageViewControllerTransitionStyle,
        navigationOrientation: UIPageViewControllerNavigationOrientation,
        options: [String : Any]? = nil)
    {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        self.hidesBottomBarWhenPushed = true
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI
    private func configUI() {
        self.pageImage = UIImageView()
        self.configPages()
    }
    
    private func configPages() {
        self.dataSource = self
        let startIndex = 0
        
        let firstPageViewModel = WKPageViewModel(
            title: NSLocalizedString("She say", comment: ""),
            description: NSLocalizedString("Do you love me?", comment: ""),
            image: nil)
        let firstPage = WKPageView(viewModel: firstPageViewModel)

        let secondPageViewModel = WKPageViewModel(
            title: NSLocalizedString("I tell her", comment: ""),
            description: NSLocalizedString("Only partly.", comment: ""),
            image: nil)
        let secondPage = WKPageView(viewModel: secondPageViewModel)
        
        let thirdPageViewModel = WKPageViewModel(
            title: NSLocalizedString("I only love my bed and my momma", comment: ""),
            description: NSLocalizedString("I'm sorry.", comment: ""),
            image: nil)
        let thirdPage = WKPageView(viewModel: thirdPageViewModel)
        
        self.pages.append(firstPage)
        self.pages.append(secondPage)
        self.pages.append(thirdPage)
        setViewControllers([pages[startIndex]], direction: .forward, animated: true, completion: nil)
        
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = startIndex
        
        self.view.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

/* UIPageViewController Delegate */
extension WKPageContentView {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController)
        -> UIViewController?
    {
        return UIViewController()
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController)
        -> UIViewController?
    {
        return UIViewController()
    }
}
