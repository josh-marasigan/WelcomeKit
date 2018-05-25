//
//  WelcomeViewController.swift
//  WelcomeKit
//
//  Created by Josh Marasigan on 5/24/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation

public class WelcomeViewController: UIViewController {
    
    // MARK: - Parameters
    private var leadColor: UIColor?
    private var secondaryColor: UIColor?
    private var gradientBackgroundColor = CAGradientLayer()
    
    // MARK: - Init
    public init(leadColor: UIColor?, secondaryColor: UIColor?) {
        self.leadColor = leadColor
        self.secondaryColor = secondaryColor
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    // MARK: - UI
    private func configUI() {
        self.setBackgroundColor()
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
        self.gradientBackgroundColor.startPoint = CGPoint(x: 0, y: 1)
        self.gradientBackgroundColor.endPoint = CGPoint(x: 1, y: 0)
        self.view.layer.addSublayer(self.gradientBackgroundColor)
    }
}
