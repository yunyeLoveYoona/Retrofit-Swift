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
        test.addTarget(self, action: #selector(ViewController.testHttp), forControlEvents: UIControlEvents.TouchUpInside)
        
        retrofit = Retrofit.builder().baseUrl("http://image.baidu.com/").build()
        
        retrofit.client().addNetworkInterceptor(Interceptor({ (chain) -> Response! in
            print("请求拦截\(chain.request().url.absoluteString)")
            let response = try chain.proceed()
            return response
            
        }))
        
        
        
    }
    
    func testHttp() {
        for _ in 1...10{
            let call =  retrofit.call("search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&step_word=&hs=0&pn=0&spn=0&di=13224284040&pi=0&rn=1&tn=baiduimagedetail&is=&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=4080200953%2C2377494573&os=4160625810%2C10830226&simid=3590007912%2C373860375&adpicid=0&ln=1983&fr=&fmq=1473672701141_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fpic14.nipic.com%2F20110610%2F7181928_110502231129_2.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bgtrtv_z%26e3Bv54AzdH3Ffi5oAzdH3FnAzdH3FldAzdH3F9mld8dchjnnv9v89_z%26e3Bip4s&gsm=0&rpstart=0&rpnum=0", httpMethod: Request.HttpMethod.GET)
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

