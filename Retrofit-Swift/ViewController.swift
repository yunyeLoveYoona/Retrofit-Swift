//
//  ViewController.swift
//  Retrofit-Swift
//
//  Created by 叶云 on 16/9/12.
//  Copyright © 2016年 叶云. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var retrofit : Retrofit!
    
    @IBOutlet weak var test: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        test.addTarget(self, action: #selector(ViewController.testHttp), for: UIControlEvents.touchUpInside)
        
        retrofit = Retrofit.builder().baseUrl("http://imgsrc.baidu.com/").build()
        
        retrofit.client().addNetworkInterceptor(Interceptor({ (chain) -> Response! in
            print("请求拦截\(chain.request().url.absoluteString)")
            let response = try chain.proceed()
            return response
            
        }))
        
        
        
    }
    
    func testHttp() {
        for _ in 1...10{
            let call =  retrofit.call("forum/w%3D580/sign=79520e92632762d0803ea4b790ed0849/8a6104a4462309f740ec1ca3720e0cf3d6cad6a8.jpg", httpMethod: Request.HttpMethod.get)
            call.enqueue(Callback({ (response) in
                print("请求成功")
                }, { (error) in
                    print("请求失败")
            }))
        }
        retrofit.client().stopQueue()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

