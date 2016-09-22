//
//  Callback.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import Foundation
class Callback {
    var onResponse : (_ response : Response) ->Void
    var onFailure  : (_ error : String) ->Void
    init(_ onResponse : @escaping (_ response : Response) ->Void, _ onFailure : @escaping (_ error : String) ->Void){
        self.onFailure = onFailure
        self.onResponse = onResponse
    }
    
}
