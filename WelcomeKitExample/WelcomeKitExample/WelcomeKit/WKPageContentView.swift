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
    fileprivate var startIndex: Int? = 0
    
    // MARK: - Optional Properties
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
    ///   - alternativeStartIndex: Optional Int indicating a starting page index other than zero
    init(
        pages: [WKPageView],
        delegate: WKPageContentViewDelegate,
        pageControlColor: UIColor? = nil,
        alternativeStartIndex: Int? = nil)
    {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        // Set delegates to self to receive actions
        self.dataSource = self
        self.delegate = self
        
        // Set class properties
        self.contenViewDelegate = delegate
        self.pages = pages
        self.pageControlColor = pageControlColor
        self.startIndex = alternativeStartIndex
        
        // Configure WKPageContentView's UI
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI
    private func configUI() {
        self.configPages()
    }
    
    // MARK: - Configure Page Views
    private func configPages() {
        // Set ViewControllers starting w/ index of our first welcome page
        setViewControllers(
            [pages[self.startIndex ?? 0]],
            direction: .forward,
            animated: true,
            completion: nil
        )
        
        // Configure pageControl properties
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
        self.pageControl.currentPage = self.startIndex ?? 0
        
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
            return (pageIndex == 0) ? nil : self.pages[pageIndex - 1]
        }
        
        // Return nil if this is the first page
        return nil
    }
    
    // Called after if user goes to the next page
    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let pageIndex = self.pages.index(of: viewController) {
            self.contenViewDelegate?.onNextPage(pageIndex: pageIndex)
            return pageIndex < self.pages.count - 1 ? self.pages[pageIndex + 1] : nil
        }
        
        // Return nil if this is the last page
        return nil
    }
}


