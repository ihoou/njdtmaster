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
        屏幕尺寸
     */
    static let ADMIN_SRCEEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    static let ADMIN_SRCEEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
    
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
    static var TERMINAL_IDENTIFICATION:String = "null"
    static let APPLICATION_VERSION:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String
    static var LAST_LOGIN_TIME:String = "1970-01-01 00:00:00"
    static let CUSTOMER_HOTLINE:String = "15366181339"
    static let CACHE_CLEANUP:String = "点击此处清理缓存"
    
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
