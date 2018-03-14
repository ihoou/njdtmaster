//
//  WelcomViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/2/7.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import AdSupport


class WelcomeViewController: UIViewController{
    
    
    
    //在控制器定义全局的可变data，用户存储接收的数据
    var jsonData:NSMutableData = NSMutableData()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        var uuid:String!
        uuid = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//        print("batteryLevel=\(UIDevice.current.batteryLevel)")
//        print(ssss.replacingOccurrences(of: "-", with: ""))
//        print("localizedModel=\(UIDevice.current.localizedModel)")
//        print("model=\(UIDevice.current.model)")
//        print("name=\(UIDevice.current.name)")
//        print("systemName=\(UIDevice.current.systemName)")
//        print("systemVersion=\(UIDevice.current.systemVersion)")
        //调用登陆接口
        let md = NSMutableDictionary()
        uuid = uuid.replacingOccurrences(of: "-", with: "")
//        print("UUID=\(uuid)")
        md.setValue("{\"txcode\":\"login\",\"imei\":\"\(uuid as String)\"}", forKey: "data")
        
        let a = BaseNetwork()
        var result:String = "Null"
        a.post(url: "http://njdt.njtjy.org.cn:10011/njliftMaint/android/process.action", params: md)
        
        
        let time1: TimeInterval = 0.3
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time1) {
            let toast = ToastView()
            toast.showLoadingDlg()
            toast.showFinished(sender: self)
        }
        
        let time: TimeInterval = 2.3
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            //print("2 秒后输出")
            result = a.getReturnValue()
            //print(result)
            let dic:NSDictionary = self.getDictionaryFromJSONString(jsonString: result)
//            for (key,value) in dic {
//                print("键：\(key),值：\(value)")
//            }
            let loginflag:String = dic["rescode"]! as! String
            if loginflag == "1" {
                print("登陆失败，原因是：\(dic["msg"]!)")//登陆失败，已注册但未认领，跳转认领提示页面
                let toast = ToastView()
                toast.showToast(text: "已经注册！请联系公司管理员认领！", pos: .Bottom)
                
                let time: TimeInterval = 3//延迟
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                    exit(0)//使用该方法，上架苹果商店可能被拒。
                }
                
            }else if loginflag == "0"{
                print("登陆成功，原因是：\(dic["msg"]!)")
                //登陆成功，跳转至主页面
//                self.performSegue(withIdentifier: "validatesuccess", sender: nil)
//                 self.present(MainTabViewController(), animated:true, completion:nil)
                (UIApplication.shared.delegate as! AppDelegate).loadMainView()
            }else if loginflag == "2"{
                print("登陆失败，原因是：\(dic["msg"]!)")
                //登陆失败，将跳转至注册页面
                self.performSegue(withIdentifier: "validatefaild", sender: nil)
            }
        }
        
        
    }
    
 
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
