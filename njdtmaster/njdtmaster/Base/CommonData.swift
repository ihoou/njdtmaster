//
//  CommonData.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/14.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import Foundation
import UIKit

class CommonData {
    
    /*
        接口参数txcode
     */
    static let TXCODE_LOGIN = "login"//登陆验证接口
    static let TXCODE_REGISTER = "register"//注册接口
    static let TXCODE_PENDING_FORM = "pendingForm" //获取救援任务（维保单位）
    static let TXCODE_MY_FORM = "myForm"//获取我的待任务列表
    
    
    /*
        屏幕尺寸
     */
    static let ADMIN_SRCEEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    static let ADMIN_SRCEEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
    static var ADD_ADAPTATION_HEIGHT:CGFloat = 5
    /*
        终端信息
     */
    static let COMPANY_NAME_L:String = "单位名称"
    static let USER_NAME_L:String = "用户名称"
    static let TERMINAL_IDENTIFICATION_L:String = "终端标识"
    static let APPLICATION_VERSION_L:String = "软件版本"
    static let LAST_LOGIN_TIME_L:String = "上次登陆时间"
    static let CUSTOMER_HOTLINE_L:String = "客服热线"
    static let CACHE_CLEANUP_L:String = "缓存清理"
    
    static var COMPANY_NAME:String = "测试单位"
    static var USER_NAME:String = "测试姓名"
    static var USER_ROLE:String = "0"
    static var TERMINAL_IDENTIFICATION:String = "null"
    static let APPLICATION_VERSION:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String
    static var LAST_LOGIN_TIME:String = "1970-01-01 00:00:00"
    static let CUSTOMER_HOTLINE:String = "15366181339"
    static let CACHE_CLEANUP:String = "点击此处清理缓存"
    //其他注册信息
    static var CLIENT_ID:String = ""
    static var MAINT_ID:String = ""
    
    //侧边菜单信息
    static var SIDE_TITILE_ARRAY = ["公告信息", "我的排名", "我的信息", "维保统计"]
    static var SIDE_IMAGE_ARRAY = ["icon_side_ggxx", "icon_side_wdpm", "icon_side_wdxx", "icon_side_wbtj"]
    
    /** Picker Base Infomation */
    static let stateKey:String = "state"
    static let citiesKey:String = "cities"
    static let cityKey:String = "city"
    static let areasKey:String = "areas"
    static let AP_DEFAULT_BAR_TINT_COLOR:UIColor = UIColor(red: 60/255, green: 226/255, blue: 208/255, alpha: 1.0)
    
    enum PickerType: Int {
        case first
        case second
        case area
    }
    /*
        NetWork Address
     */
    static let WEATHER_PATH:String = "http://api.map.baidu.com/telematics/v3/weather"//百度天气接口
    //正式平台服务器地址(96333)
    static let CONSTANT_PATH_GET:String = "http://202.102.108.167:18082/njlift/android/process.action?data="
    static let CONSTANT_PATH_POST:String = "http://202.102.108.167:18082/njlift/android/process.action?"
    //鸿信服务器地址（测试，已经废弃）
//    static let CONSTANT_PATH_GET_MAINT:String = "http://202.102.108.22:18081/njliftMaint/android/process.action?data="
//    static let CONSTANT_PATH_POST_MAINT:String = "http://202.102.108.22:18081/njliftMaint/android/process.action?"
    //域名地址
    static let CONSTANT_PATH_GET_MAINT:String = "http://njdt.njtjy.org.cn:10011/njliftMaint/android/process.action?data="
    static let CONSTANT_PATH_POST_MAINT:String = "http://njdt.njtjy.org.cn:10011/njliftMaint/android/process.action?"
    //江北服务器组
//    static let CONSTANT_PATH_GET_MAINT:String = "http://218.2.210.178:10011/njliftMaint/android/process.action?data="
//    static let CONSTANT_PATH_POST_MAINT:String = "http://218.2.210.178:10011/njliftMaint/android/process.action?"
    
}
