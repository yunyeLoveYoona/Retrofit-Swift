//
//  Callback.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Callback {
    var onResponse : (response : Response) ->Void
    var onFailure  : (error : String) ->Void
    init(_ onResponse : (response : Response) ->Void, _ onFailure : (error : String) ->Void){
        self.onFailure = onFailure
        self.onResponse = onResponse
    }
    
}
