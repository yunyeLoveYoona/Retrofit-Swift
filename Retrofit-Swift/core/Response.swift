//
//  Response.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Response {
    var body : Data!
    var code : Int!
    var method : Request.HttpMethod!
    var url : URL!
    
    init(url : URL,method : Request.HttpMethod){
        self.url = url
        self.method = method
    }
    
    func strBody() -> NSString!{
        return NSString(data: body!, encoding: String.Encoding.utf8.rawValue)
    }
}
