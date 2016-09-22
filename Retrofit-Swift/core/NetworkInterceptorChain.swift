//
//  NetworkInterceptorChain.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class NetworkInterceptorChain: Chain {
    fileprivate var mRequest : Request!
    fileprivate var mResponse : Response!
    fileprivate var configuration : URLSessionConfiguration!
    fileprivate var nsRequest : NSMutableURLRequest!
    fileprivate var session : URLSession!
    
    init(request : Request)throws {
        self.mRequest = request
        configuration = URLSessionConfiguration.default
        nsRequest = NSMutableURLRequest(url: request.url as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: TimeInterval(request.getTimeOut()))
        nsRequest.httpMethod = request.getMethod()
        if request.httpBody != nil{
            let data:Data = try JSONSerialization.data(withJSONObject: request.httpBody, options: JSONSerialization.WritingOptions.prettyPrinted)
            nsRequest.httpBody = data
        }
        session = URLSession(configuration: configuration)
        
    }
    
    func request() -> Request {
        return mRequest
    }
    
    func proceed() throws -> Response {
        var nsError : NSError!
        let semaphore = DispatchSemaphore(value: 0)
        let dataTask = session.dataTask(with: nsRequest as URLRequest,completionHandler: {(data, response, error) -> Void in
            if error != nil{
                nsError = error as NSError!
            }else{
                self.mResponse = Response(url: self.mRequest.url,method: self.mRequest.method)
                self.mResponse.code = 200
                self.mResponse.body = data
            }
            semaphore.signal()
        })
        
        dataTask.resume()
        let dispatchTimeoutResult = semaphore.wait(timeout: DispatchTime.distantFuture)
        if dispatchTimeoutResult == DispatchTimeoutResult.success{
            if nsError != nil{
                throw nsError.description
            }
            return mResponse
        }else{
            throw "请求超时"

        }
    }
    
    
    func addHeader(_ value: String, forHTTPHeaderField: String){
        nsRequest.addValue(value, forHTTPHeaderField: forHTTPHeaderField)
    }
    
    
    func setConfiguration(_ configuration : URLSessionConfiguration){
        session = URLSession(configuration: configuration)
    }
    
    func getHttpBody() -> NSDictionary{
        return mRequest.httpBody
    }
    
    
    func setHttpBody(_ httpBody : NSDictionary)throws{
        mRequest.httpBody = httpBody
        let data:Data = try JSONSerialization.data(withJSONObject: httpBody, options: JSONSerialization.WritingOptions.prettyPrinted)
        nsRequest.httpBody = data
    }
    
    
    
    
}
