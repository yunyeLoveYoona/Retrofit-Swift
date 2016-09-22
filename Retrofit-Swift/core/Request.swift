//
//  Request.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Request {
    var method : HttpMethod!
    var url : URL!
    fileprivate var client : OkHttpClient!
    var httpBody : NSDictionary!
    
    init(url : URL,method : HttpMethod,client : OkHttpClient){
        self.url = url
        self.method = method
        self.client = client
    }
    
    
    func enqueue(_ call : Call){
        client.enqueue(call)
    }
    
    func sendRequest()throws -> Response!{
        if client.networkInterceptors().count > 0{
           return try client.networkInterceptors()[0].intercpt(NetworkInterceptorChain(request: self))
        }else{
           return try NetworkInterceptorChain(request: self).proceed()
        }
    }
    
    func getMethod() -> String{
        switch method! {
        case HttpMethod.get:
            return "GET"
        case HttpMethod.post:
            return "POST"
        }
    }
    
    func getTimeOut() -> Int{
        return client.timeOut
    }
    
    func isStop() -> Bool{
        return client.isStopQueue()
    }
    
    enum HttpMethod {
        case post, get
    }
}

