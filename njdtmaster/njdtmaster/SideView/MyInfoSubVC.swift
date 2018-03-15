//
//  MyInfoSubViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/14.
//  Copyright © 2018年 尹浩. All rights reserved.
//
import UIKit

class MyInfoSubVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let bg_IV = UIImageView(image: UIImage(named: "myinfo"))
        bg_IV.frame = CGRect(x:0,y:90,width:CommonData.ADMIN_SRCEEN_WIDTH,height:CommonData.ADMIN_SRCEEN_HEIGHT)
        bg_IV.isUserInteractionEnabled = true
        view.addSubview(bg_IV)
//        print(CommonData.COMPANY_NAME)
//        print(CommonData.TERMINAL_IDENTIFICATION)
//        print(CommonData.LAST_LOGIN_TIME)
//        print(CommonData.USER_NAME)
//        print(CommonData.APPLICATION_VERSION)
        //单位名称
        let companyNameIV = UIImageView(image: UIImage(named: "ic_setting_company"))
        let companyNameL = UILabel()
        let companyName = UILabel()
        companyNameL.text = CommonData.COMPANY_NAME_L
        companyName.text = CommonData.COMPANY_NAME
        companyNameL.font = UIFont.systemFont(ofSize: 12)
        companyName.font = UIFont.systemFont(ofSize: 12)
        companyNameIV.frame = CGRect(x:16 ,y:106, width:20, height:20)
        companyNameL.frame = CGRect(x:46 ,y:106, width:60, height:22)
        companyName.frame = CGRect(x:126 ,y:106, width:260, height:22)
        companyNameL.textAlignment = NSTextAlignment.left
        companyName.textAlignment = NSTextAlignment.left
        companyName.textColor = UIColor.orange
        view.addSubview(companyNameIV)
        view.addSubview(companyNameL)
        view.addSubview(companyName)
        //用户姓名
        let userNameIV = UIImageView(image: UIImage(named: "ic_setting_user"))
        let userNameL = UILabel()
        let userName = UILabel()
        userNameL.text = CommonData.USER_NAME_L
        userName.text = CommonData.USER_NAME
        userNameL.font = UIFont.systemFont(ofSize: 12)
        userName.font = UIFont.systemFont(ofSize: 12)
        userNameIV.frame = CGRect(x:16 ,y:139, width:20, height:20)
        userNameL.frame = CGRect(x:46 ,y:139, width:60, height:22)
        userName.frame = CGRect(x:126 ,y:139, width:260, height:22)
        userNameL.textAlignment = NSTextAlignment.left
        userName.textAlignment = NSTextAlignment.left
        userName.textColor = UIColor.orange
        view.addSubview(userNameIV)
        view.addSubview(userNameL)
        view.addSubview(userName)
        //终端标识
        let terminalIdentificationIV = UIImageView(image: UIImage(named: "ic_setting_client"))
        let terminalIdentificationL = UILabel()
        let terminalIdentification = UILabel()
        terminalIdentificationL.text = CommonData.TERMINAL_IDENTIFICATION_L
        terminalIdentification.text = CommonData.TERMINAL_IDENTIFICATION
        terminalIdentificationL.font = UIFont.systemFont(ofSize: 12)
        terminalIdentification.font = UIFont.systemFont(ofSize: 12)
        terminalIdentificationIV.frame = CGRect(x:16 ,y:172, width:20, height:20)
        terminalIdentificationL.frame = CGRect(x:46 ,y:172, width:60, height:22)
        terminalIdentification.frame = CGRect(x:126 ,y:172, width:260, height:22)
        terminalIdentificationL.textAlignment = NSTextAlignment.left
        terminalIdentification.textAlignment = NSTextAlignment.left
        terminalIdentification.textColor = UIColor.orange
        view.addSubview(terminalIdentificationIV)
        view.addSubview(terminalIdentificationL)
        view.addSubview(terminalIdentification)
        //软件版本
        let applicationVersionIV = UIImageView(image: UIImage(named: "ic_setting_version"))
        let applicationVersionL = UILabel()
        let applicationVersion = UILabel()
        applicationVersionL.text = CommonData.APPLICATION_VERSION_L
        applicationVersion.text = CommonData.APPLICATION_VERSION
        applicationVersionL.font = UIFont.systemFont(ofSize: 12)
        applicationVersion.font = UIFont.systemFont(ofSize: 12)
        applicationVersionIV.frame = CGRect(x:16 ,y:226, width:20, height:20)
        applicationVersionL.frame = CGRect(x:46 ,y:226, width:60, height:22)
        applicationVersion.frame = CGRect(x:126 ,y:226, width:260, height:22)
        applicationVersionL.textAlignment = NSTextAlignment.left
        applicationVersion.textAlignment = NSTextAlignment.left
        applicationVersion.textColor = UIColor.orange
        view.addSubview(applicationVersionIV)
        view.addSubview(applicationVersionL)
        view.addSubview(applicationVersion)
        //上次登陆时间
        let lastLoginTimeIV = UIImageView(image: UIImage(named: "ic_setting_lasttime"))
        let lastLoginTimeL = UILabel()
        let lastLoginTime = UILabel()
        lastLoginTimeL.text = CommonData.LAST_LOGIN_TIME_L
        lastLoginTime.text = CommonData.LAST_LOGIN_TIME
        lastLoginTimeL.font = UIFont.systemFont(ofSize: 12)
        lastLoginTime.font = UIFont.systemFont(ofSize: 12)
        lastLoginTimeIV.frame = CGRect(x:16 ,y:261,width:20,height:20)
        lastLoginTimeL.frame = CGRect(x:46 ,y:261,width:80,height:22)
        lastLoginTime.frame = CGRect(x:126 ,y:261,width:260,height:22)
        lastLoginTimeL.textAlignment = NSTextAlignment.left
        lastLoginTime.textAlignment = NSTextAlignment.left
        lastLoginTime.textColor = UIColor.orange
        view.addSubview(lastLoginTimeIV)
        view.addSubview(lastLoginTimeL)
        view.addSubview(lastLoginTime)
        //客服热线
        let customerHotlineIV = UIImageView(image: UIImage(named: "ic_setting_service"))
        let customerHotlineL = UILabel()
        let customerHotline = UILabel()
        customerHotlineL.text = CommonData.CUSTOMER_HOTLINE_L
        customerHotline.text = CommonData.CUSTOMER_HOTLINE
        customerHotlineL.font = UIFont.systemFont(ofSize: 12)
        customerHotline.font = UIFont.systemFont(ofSize: 12)
        customerHotlineIV.frame = CGRect(x:16 ,y:294,width:20,height:20)
        customerHotlineL.frame = CGRect(x:46 ,y:294,width:60,height:22)
        customerHotline.frame = CGRect(x:126 ,y:294,width:260,height:22)
        customerHotlineL.textAlignment = NSTextAlignment.left
        customerHotline.textAlignment = NSTextAlignment.left
        customerHotline.textColor = UIColor.orange
        view.addSubview(customerHotlineIV)
        view.addSubview(customerHotlineL)
        view.addSubview(customerHotline)
        //缓存清理
        let cacheCleanupIV = UIImageView(image: UIImage(named: "icon_safecheck_wbdw"))
        let cacheCleanupL = UILabel()
        let cacheCleanup = UILabel()
        cacheCleanupL.text = CommonData.CACHE_CLEANUP_L
        cacheCleanup.text = CommonData.CACHE_CLEANUP
        cacheCleanupL.font = UIFont.systemFont(ofSize: 12)
        cacheCleanup.font = UIFont.systemFont(ofSize: 12)
        cacheCleanupIV.frame = CGRect(x:16 ,y:348,width:20,height:20)
        cacheCleanupL.frame = CGRect(x:46 ,y:348,width:60,height:22)
        cacheCleanup.frame = CGRect(x:126 ,y:348,width:260,height:22)
        cacheCleanupL.textAlignment = NSTextAlignment.left
        cacheCleanup.textAlignment = NSTextAlignment.left
        cacheCleanup.textColor = UIColor.orange
        view.addSubview(cacheCleanupIV)
        view.addSubview(cacheCleanupL)
        view.addSubview(cacheCleanup)
        //设置点击时间
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("doCleanupCache:")))
        cacheCleanup.addGestureRecognizer(tap)
//        //带背景和边框
//        let label2 = UILabel()
//        label2.frame = CGRect(x:50, y:490, width:100, height:35)
//        label2.text = "圆角Label"
//        label2.textColor = UIColor.black
//        label2.backgroundColor = UIColor.white
//        label2.textAlignment = NSTextAlignment.center
//        //边框设置圆角
//        label2.layer.cornerRadius = 8
//        label2.layer.borderWidth = 1
//        label2.layer.borderColor = UIColor.gray.cgColor
//        view.addSubview(label2)
    }
    func doCleanupCache(sender:UITapGestureRecognizer) {
        let toast = ToastView()
        print("并未进行清理，仅仅打印！后续实现")
        toast.showToast(text: "应用缓存已经清理", pos: .Bottom)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}
