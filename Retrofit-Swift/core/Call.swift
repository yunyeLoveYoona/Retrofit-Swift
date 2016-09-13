//
//  Call.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Call{
    private var request : Request!
    private var callback : Callback!
    private var isStop = false
    
    init(request : Request){
        self.request = request
    }
    
    func getDispatchBlock() -> dispatch_block_t {
        let block = {
            if(!self.isStop && !self.request.isStop()){
                do {
                    let response = try self.request.sendRequest()
                    if self.callback != nil{
                        if response == nil{
                            self.callback.onFailure(error: "请求失败")
                        }else{
                            self.callback.onResponse(response: response)
                        }
                        
                    }
                }catch let error{
                    if self.callback != nil{
                        self.callback.onFailure(error: error as! String)
                    }
                }
            }
        }
        return block
    }
    
    func enqueue(callback : Callback){
        self.callback = callback
        request.enqueue(self)
    }
    
    func stop() {
        isStop = true
    }
    
}