//
//  TabBarController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/30/18.
//  Copyright © 2018 Jeremiah Reynolds. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var autorotatable: Bool?
    
    override var shouldAutorotate: Bool {
        if let autorotatable = autorotatable {
            return autorotatable
        }
        return true
    }
}
