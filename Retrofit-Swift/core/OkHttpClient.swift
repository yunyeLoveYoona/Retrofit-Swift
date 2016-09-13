//
//  OkHttpClient.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation

class OkHttpClient {
    private var queue : dispatch_queue_t!
    var timeOut : Int!
    private var networkInterceptorArray : Array<Interceptor>!
    private var isStop = false
    
    init(){
        queue = dispatch_queue_create("okhttp_quue", DISPATCH_QUEUE_CONCURRENT)
        timeOut = 30
        networkInterceptorArray = Array<Interceptor>()
    }
    
    func networkInterceptors() -> Array<Interceptor> {
        return networkInterceptorArray
    }
    
    func addNetworkInterceptor(interceptor : Interceptor){
        networkInterceptorArray.append(interceptor)
    }
    
    func enqueue(call : Call){
        isStop = false
        dispatch_async(queue, call.getDispatchBlock())
    }
    
    func isStopQueue() -> Bool{
        return isStop
    }
    
    func stopQueue(){
        isStop = true
    }

}
