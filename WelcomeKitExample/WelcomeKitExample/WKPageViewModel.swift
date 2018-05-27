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
    var image: UIImage? { get set }
}

class WKPageViewModel: WKPageViewModelType {
    // MARK: - Properties
    var title: String?
    var description: String?
    var image: UIImage?
    
    init(title: String?, description: String?, image: UIImage?) {
        self.title = title
        self.description = description
        self.image = image
    }
}
