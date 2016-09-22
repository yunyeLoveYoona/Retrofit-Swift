//
//  OkHttpClient.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation

class OkHttpClient {
    fileprivate var queue : DispatchQueue!
    var timeOut : Int!
    fileprivate var networkInterceptorArray : Array<Interceptor>!
    fileprivate var isStop = false
    
    init(){
        queue = DispatchQueue(label: "okhttp_quue", attributes: DispatchQueue.Attributes.concurrent)
        timeOut = 30
        networkInterceptorArray = Array<Interceptor>()
    }
    
    func networkInterceptors() -> Array<Interceptor> {
        return networkInterceptorArray
    }
    
    func addNetworkInterceptor(_ interceptor : Interceptor){
        networkInterceptorArray.append(interceptor)
    }
    
    func enqueue(_ call : Call){
        isStop = false
        queue.async(execute: call.getDispatchBlock())
    }
    
    func isStopQueue() -> Bool{
        return isStop
    }
    
    func stopQueue(){
        isStop = true
    }

}
