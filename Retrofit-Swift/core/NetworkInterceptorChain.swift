//
//  NetworkInterceptorChain.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class NetworkInterceptorChain: Chain {
    private var mRequest : Request!
    private var mResponse : Response!
    private var configuration : NSURLSessionConfiguration!
    private var nsRequest : NSMutableURLRequest!
    private var session : NSURLSession!
    
    init(request : Request)throws {
        self.mRequest = request
        configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        nsRequest = NSMutableURLRequest(URL: request.url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: NSTimeInterval(request.getTimeOut()))
        nsRequest.HTTPMethod = request.getMethod()
        if request.httpBody != nil{
            let data:NSData = try NSJSONSerialization.dataWithJSONObject(request.httpBody, options: NSJSONWritingOptions.PrettyPrinted)
            nsRequest.HTTPBody = data
        }
        session = NSURLSession(configuration: configuration)
        
    }
    
    func request() -> Request {
        return mRequest
    }
    
    func proceed() throws -> Response {
        var nsError : NSError!
        let semaphore = dispatch_semaphore_create(0)
        let dataTask = session.dataTaskWithRequest(nsRequest,completionHandler: {(data, response, error) -> Void in
            if error != nil{
                nsError = error
            }else{
                self.mResponse = Response(url: self.mRequest.url,method: self.mRequest.method)
                self.mResponse.code = 200
                self.mResponse.body = data
            }
            dispatch_semaphore_signal(semaphore)
        }) as NSURLSessionTask
        dataTask.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        if nsError != nil{
            throw nsError.description
        }
        return mResponse
    }
    
    
    func addHeader(value: String, forHTTPHeaderField: String){
        nsRequest.addValue(value, forHTTPHeaderField: forHTTPHeaderField)
    }
    
    
    func setConfiguration(configuration : NSURLSessionConfiguration){
        session = NSURLSession(configuration: configuration)
    }
    
    func getHttpBody() -> NSDictionary{
        return mRequest.httpBody
    }
    
    
    func setHttpBody(httpBody : NSDictionary)throws{
        mRequest.httpBody = httpBody
        let data:NSData = try NSJSONSerialization.dataWithJSONObject(httpBody, options: NSJSONWritingOptions.PrettyPrinted)
        nsRequest.HTTPBody = data
    }
    
    
    
    
}