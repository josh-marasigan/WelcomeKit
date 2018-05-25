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
        let leadColor = UIColor(red:1.00, green:0.60, blue:0.62, alpha:1.0)
        let secondaryColor = UIColor(red:0.98, green:0.82, blue:0.77, alpha:1.0)

        let welcomeVC = WelcomeViewController(
            leadColor: leadColor,
            secondaryColor: secondaryColor
        )
        
        self.view.addSubview(welcomeVC.view)
        welcomeVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

