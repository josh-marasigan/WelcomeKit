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

class WKViewController: UIViewController {
    
    // MARK: - Parameters
    private var leadColor: UIColor?
    private var secondaryColor: UIColor?
    private var gradientBackgroundColor = CAGradientLayer()
    
    fileprivate lazy var pageContentView: WKPageContentView = {
        let contentView = WKPageContentView(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        return contentView
    }()
    
    // MARK: - Init
    init(leadColor: UIColor?, secondaryColor: UIColor?) {
        self.leadColor = leadColor
        self.secondaryColor = secondaryColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    // MARK: - UI
    private func configUI() {
        self.setBackgroundColor()
        
        self.view.addSubview(self.pageContentView.view)
        self.pageContentView.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(264)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-64)
        }
    }
    
    private func setBackgroundColor() {
        guard let leadColor = self.leadColor else {
            self.view.backgroundColor = .white
            return
        }
        
        guard let secondaryColor = self.secondaryColor else {
            self.view.backgroundColor = self.leadColor ?? .white
            return
        }
        
        self.gradientBackgroundColor.frame = self.view.bounds
        self.gradientBackgroundColor.colors = [leadColor.cgColor, secondaryColor.cgColor]
        self.gradientBackgroundColor.startPoint = CGPoint(x: 1, y: 1)
        self.gradientBackgroundColor.endPoint = CGPoint(x: 1, y: 0)
        self.view.layer.addSublayer(self.gradientBackgroundColor)
    }
}
