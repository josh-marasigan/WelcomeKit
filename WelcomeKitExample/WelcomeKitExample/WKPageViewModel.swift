//
//  WKPageViewModel.swift
//  WelcomeKitExample
//
//  Created by Josh Marasigan on 5/27/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation
import UIKit

protocol WKPageViewModelType {
    var title: String? { get set }
    var description: String? { get set }
}

class WKPageViewModel: WKPageViewModelType {
    // MARK: - Properties
    var title: String?
    var description: String?
    
    /// WKPageViewModel
    ///
    /// - Parameters:
    ///   - title: The title text for a WKPageView
    ///   - description: The subtitle text for a WKPageView
    init(title: String?, description: String?) {
        self.title = title
        self.description = description
    }
}
