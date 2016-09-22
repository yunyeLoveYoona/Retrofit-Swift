//
//  Call.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Call{
    fileprivate var request : Request!
    fileprivate var callback : Callback!
    fileprivate var isStop = false
    
    init(request : Request){
        self.request = request
    }
    
    func getDispatchBlock() -> ()->() {
        let block = {
            if(!self.isStop && !self.request.isStop()){
                do {
                    let response = try self.request.sendRequest()
                    if self.callback != nil{
                        if response == nil{
                            self.callback.onFailure("请求失败")
                        }else{
                            self.callback.onResponse(response!)
                        }
                        
                    }
                }catch let error{
                    if self.callback != nil{
                        self.callback.onFailure(error as! String)
                    }
                }
            }
        }
        return block
    }
    
    func enqueue(_ callback : Callback){
        self.callback = callback
        request.enqueue(self)
    }
    
    func stop() {
        isStop = true
    }
    
}
