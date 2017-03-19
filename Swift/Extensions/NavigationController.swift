//
//  NavigationController.swift
//  NODAT
//
//  Created by NavdeepSingh on 28/02/17.
//  Copyright © 2017 Trantor Inc. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
}
