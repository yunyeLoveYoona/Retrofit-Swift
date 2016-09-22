//
//  Retrofit.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Retrofit{
    fileprivate var baseUrl : BaseUrl!
    fileprivate var mClient : OkHttpClient!
    
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
    
    
    func call(_ url : String,httpMethod : Request.HttpMethod) -> Call {
         return call(url, httpMethod: httpMethod, httpBody: nil)
    }
    
    
    func call(_ url : String,httpMethod : Request.HttpMethod,httpBody : NSDictionary!) -> Call {
        let request = Request(url: baseUrl.composeUrl(url), method: httpMethod, client: mClient)
        if httpBody != nil{
            request.httpBody = httpBody
        }
        let call = Call(request: request)
        return call
    }
    
    class Builder : BaseUrl{
        fileprivate var mBaseUrl : String!
        
        func baseUrl(_ url : String) -> Builder {
            mBaseUrl = url
            if !Utils.isUrl(mBaseUrl){
                print( "Illegal URL: \(mBaseUrl)")
            }
            return self
        }
        
        func baseUrl() -> URL{
            if mBaseUrl == nil{
                print( "Illegal URL: \(mBaseUrl)")
            }
            return URL(string: mBaseUrl)!
        }
        
        func composeUrl(_ url : String) -> URL {
            if !Utils.isUrl("\(mBaseUrl!)\(url)"){
                print("Illegal URL: \(mBaseUrl)\(url)")
            }
            return URL(string: "\(mBaseUrl!)\(url)")!
        }
        
        func build() -> Retrofit {
            return Retrofit(baseUrl: self)
        }
    }
    
    
    
    
    
    
}


extension String : Error{
    
    
}
