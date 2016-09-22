//
//  Utils.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
import UIKit
class Utils {
    static func isUrl(_ url : String) -> Bool{
        return UIApplication.shared.canOpenURL(URL(string: url)!)
    }
}
