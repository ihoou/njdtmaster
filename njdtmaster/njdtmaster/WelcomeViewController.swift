//
//  WelcomViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/2/7.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import AdSupport
import Alamofire
import SwiftyJSON


class WelcomeViewController: UIViewController{
    
    var loginFlag:String = "2"
    var loginMsg:String = ""
    
    //在控制器定义全局的可变data，用户存储接收的数据
    var jsonData:NSMutableData = NSMutableData()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let BGIV = UIImageView(image: UIImage(named: "bg_register"))
        BGIV.frame = CGRect(x:0, y:0 , width:CommonData.ADMIN_SRCEEN_WIDTH, height:CommonData.ADMIN_SRCEEN_HEIGHT)
        self.view.addSubview(BGIV)
        
        var uuid:String!
        uuid = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        if UIDevice.current.modelName.contains("Plus") {
            print("需要增加尺寸,当前设备型号：\(UIDevice.current.modelName)")
            CommonData.ADD_ADAPTATION_HEIGHT = 20 //设置屏幕尺寸适配
        }else if UIDevice.current.modelName.contains("X"){
            CommonData.ADD_ADAPTATION_HEIGHT = 30 //设置屏幕尺寸适配
        }else{
            print("设备型号：\(UIDevice.current.modelName)")
        }
        //调用登陆接口
//        let md = NSMutableDictionary()
        uuid = uuid.replacingOccurrences(of: "-", with: "")
        Alamofire.request(CommonData.CONSTANT_PATH_POST, method: .post, parameters: ["data":"{\"txcode\":\"login\",\"imei\":\"\(uuid as String)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    //print(登陆验证反馈信息：\(value))
                     let json = JSON(value)
                    //print(value)
                    self.loginFlag = json["rescode"].string!
                    self.loginMsg = json["msg"].string!
                    let time: TimeInterval = 2.3
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                        //print("2 秒后输出")
                        if self.loginFlag == "1" {
                            print("登陆失败，原因是：\(self.loginMsg)")//登陆失败，已注册但未认领，跳转认领提示页面
                            let toast = ToastView()
                            toast.showToast(text: "已经注册！请联系公司管理员认领！", pos: .Bottom)
                            
                            let time: TimeInterval = 3//延迟
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                                exit(0)//使用该方法，上架苹果商店可能被拒。
                            }
                            
                        }else if self.loginFlag == "0"{
                            print("登陆成功，原因是：\(self.loginMsg)")
                            //登陆成功，跳转至主页面
                            //                self.performSegue(withIdentifier: "validatesuccess", sender: nil)
                            //                 self.present(MainTabViewController(), animated:true, completion:nil)
                            
                            CommonData.COMPANY_NAME = json["data"]["maintName"].string!
                            CommonData.USER_NAME = json["data"]["staffName"].string!
                            CommonData.TERMINAL_IDENTIFICATION = json["data"]["staffImei"].string!
                            CommonData.LAST_LOGIN_TIME = json["data"]["lastTime"].string!
                            //加载主页面
                            (UIApplication.shared.delegate as! AppDelegate).loadMainView()
                        }else if self.loginFlag == "2"{
                            print("登陆失败，原因是：\(self.loginMsg)")
                            //登陆失败，将跳转至注册页面
                            self.performSegue(withIdentifier: "validatefaild", sender: nil)
                        }
                    }
                }else{
                    print(response.result.value!)
                }
            case false:
                print("调用登陆接口发生错误")
            }
        }
        
        let time1: TimeInterval = 0.3
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time1) {
            let toast = ToastView()
            toast.showLoadingDlg()
            toast.showFinished(sender: self)
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
