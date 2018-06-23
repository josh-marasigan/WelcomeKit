//
//  WKPageView.swift
//  WelcomeKitExample
//
//  Created by Josh Marasigan on 5/27/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class WKPageView: UIViewController {
    
    // MARK: - Properties
    fileprivate var viewModel: WKPageViewModelType!
    private var contentView: UIView!
    
    // MARK: - Public Properties
    public var titleLabel: UILabel!
    public var descriptionLabel: UILabel!
    
    /// WKPageView holds the actual displayable content for one 'page'
    ///
    /// - Parameter viewModel: A WKPageViewModelType instance holding the text information
    convenience init(viewModel: WKPageViewModelType) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.configParams()
        self.configUI()
    }
    
    // MARK: - UI
    private func configUI() {
        self.contentView = UIView()
        self.view.addSubview(self.contentView)
        
        self.contentView?.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        
        self.titleLabel?.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
        }
        
        self.descriptionLabel?.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func configParams() {
        self.titleLabel = UILabel()
        self.descriptionLabel = UILabel()
        
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.text = self.viewModel.title
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        self.titleLabel?.textColor = UIColor.white
        
        self.descriptionLabel?.lineBreakMode = .byWordWrapping
        self.descriptionLabel?.numberOfLines = 0
        self.descriptionLabel?.text = self.viewModel.description
        self.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)
        self.descriptionLabel?.textColor = UIColor.white
    }
}
