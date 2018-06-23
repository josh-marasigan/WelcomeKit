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

// MARK: - WKPageContentViewDelegate
// Sends action events to WKViewController that an interaction occured
protocol WKPageContentViewDelegate: class {
    func onNextPage(pageIndex: Int)
    func onPreviousPage(pageIndex: Int)
}

class WKPageContentView: UIPageViewController, UIPageViewControllerDataSource {
    
    // MARK: - Properties
    fileprivate var pages = [UIViewController]()
    fileprivate let pageControl = UIPageControl()
    fileprivate var pageStackCount = 0
    fileprivate var pageControlColor: UIColor?
    
    // MARK: - WKPageContentViewDelegate Instance
    fileprivate weak var contenViewDelegate: WKPageContentViewDelegate?
    
    // MARK: - Initializers
    /// WKPageContentView inherits from UIPageViewController (also delegating to itselfs data source)
    ///
    /// - Parameters:
    ///   - pages: WKPageView(s) to be displayed as a subview of WKPageContentView
    ///   - delegate: WKPageContentViewDelegate to inform conforming classes on page state changes
    ///   - pageControlColor: Optional UIColor value for the UIPageControl indicator
    init(
        pages: [WKPageView],
        delegate: WKPageContentViewDelegate,
        pageControlColor: UIColor? = nil)
    {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pages = pages
        self.pageControlColor = pageControlColor
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Initializer to set delegate to be notified of user interactions
    func setDelegate(delegate: WKPageContentViewDelegate) {
        self.contenViewDelegate = delegate
    }
    
    // MARK: - UI
    private func configUI() {
        self.configPages()
    }
    
    private func configPages() {
        // Set delegates to self to receive actions
        self.dataSource = self
        self.delegate = self
        
        // Starting index of our welcome pages
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        self.configPageControl()
        
        // Add page control to parent view and set its edges
        self.view.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // Helper to set page control properites
    private func configPageControl() {
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = 0
        
        self.pageControl.currentPageIndicatorTintColor = (self.pageControlColor ?? UIColor.white)
        self.pageControl.pageIndicatorTintColor =
            (self.pageControlColor ?? UIColor.white).withAlphaComponent(0.4)
    }
}

// MARK: - UIPageViewController Delegate
extension WKPageContentView: UIPageViewControllerDelegate {
    
    // Called after if user goes to a previous page
    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let pageIndex = self.pages.index(of: viewController) {
            self.contenViewDelegate?.onPreviousPage(pageIndex: pageIndex)
            self.pageControl.currentPage = pageIndex
            return self.pages[pageIndex]
        }
        
        // If we are at the left most page,
        // return the first page
        return self.pages[0]
    }
    
    // Called after if user goes to the next page
    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let pageIndex = self.pages.index(of: viewController) {
            self.contenViewDelegate?.onNextPage(pageIndex: pageIndex)
            self.pageControl.currentPage = pageIndex
            return self.pages[pageIndex]
        }
        
        // If we are at the right most page,
        // return the last page
        return self.pages[pages.count - 1]
    }
}


