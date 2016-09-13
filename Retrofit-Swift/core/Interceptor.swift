//
//  Interceptor.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Interceptor {
    var intercpt : (chain : Chain)throws -> Response!
    init(_ intercpt : (chain : Chain)throws -> Response!){
        self.intercpt = intercpt
    }    
}

protocol Chain{
    func request() -> Request
    
    func proceed()throws -> Response
}