//
//  BaseUrl.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
protocol BaseUrl{
    
    func baseUrl() -> NSURL
    
    func composeUrl(url : String) -> NSURL
}
