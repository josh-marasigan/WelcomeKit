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
    fileprivate var titleLabel: UILabel!
    fileprivate var descriptionLabel: UILabel!
    
    private var contentView: UIView!
    private let sidePadding = 32
    
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
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(sidePadding)
            make.trailing.equalToSuperview().offset(-sidePadding)
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
//        self.titleLabel?.font = UIFont.tcBoldFont(size: 28)
        self.titleLabel?.textColor = UIColor.white
        
        self.descriptionLabel?.lineBreakMode = .byWordWrapping
        self.descriptionLabel?.numberOfLines = 0
        self.descriptionLabel?.text = self.viewModel.description
//        self.descriptionLabel?.font = UIFont.tcRegularFont(size: 16)
        self.descriptionLabel?.textColor = UIColor.white
    }
}
