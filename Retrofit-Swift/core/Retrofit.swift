//
//  Retrofit.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Retrofit{
    private var baseUrl : BaseUrl!
    private var mClient : OkHttpClient!
    
    init(baseUrl : BaseUrl){
        self.baseUrl = baseUrl
        mClient = OkHttpClient()
    }
    
    
    func client() -> OkHttpClient!{
        return mClient
    }
    
    
    static func builder() -> Builder{
        return Builder()
    }
    
    
    func call(url : String,httpMethod : Request.HttpMethod) -> Call {
         return call(url, httpMethod: httpMethod, httpBody: nil)
    }
    
    
    func call(url : String,httpMethod : Request.HttpMethod,httpBody : NSDictionary!) -> Call {
        let request = Request(url: baseUrl.composeUrl(url), method: httpMethod, client: mClient)
        if httpBody != nil{
            request.httpBody = httpBody
        }
        let call = Call(request: request)
        return call
    }
    
    class Builder : BaseUrl{
        private var mBaseUrl : String!
        
        func baseUrl(url : String) -> Builder {
            mBaseUrl = url
            if !Utils.isUrl(mBaseUrl){
                print( "Illegal URL: \(mBaseUrl)")
            }
            return self
        }
        
        func baseUrl() -> NSURL{
            if mBaseUrl == nil{
                print( "Illegal URL: \(mBaseUrl)")
            }
            return NSURL(string: mBaseUrl)!
        }
        
        func composeUrl(url : String) -> NSURL {
            if !Utils.isUrl("\(mBaseUrl)\(url)"){
                print("Illegal URL: \(mBaseUrl)\(url)")
            }
            return NSURL(string: "\(mBaseUrl)\(url)")!
        }
        
        func build() -> Retrofit {
            return Retrofit(baseUrl: self)
        }
    }
    
    
    
    
    
    
}


extension String : ErrorType{
    
    
}