# Retrofit-Swift

一个swift网络请求框架，借鉴了Android的Retrofit框架的架构，已经实现了简单的网络请求功能。

引用：pod 'Retrofit-Swift', '~> 0.0.1'

Retrofit-Swift提供了设置baseurl的方法

Retrofit.builder().baseUrl("http://image.baidu.com/")


也提供了设置请求拦截器的方法


 retrofit.client().addNetworkInterceptor(Interceptor({ (chain) -> Response! in
            print("请求拦截\(chain.request().url.absoluteString)")
            let response = try chain.proceed()
            return response
            
        }))


网络请求的发起和停止也很简单


let call =  retrofit.call("url", httpMethod: Request.HttpMethod.GET)
            call.enqueue(Callback({ (response) in
                print("请求成功")
                }, { (error) in
                    print("请求失败")
            }))


也提供了停止所有正在进行的请求的方法

retrofit.client().stopQueue()

还提供了设置请求头的方法，等等


继续完善中，欢迎大家试毒。
