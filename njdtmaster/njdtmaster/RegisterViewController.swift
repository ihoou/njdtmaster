//
//  RegisterViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/12.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import AdSupport

class RegisterViewController: UIViewController  {

    @IBOutlet weak var userRole: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    var jsonData:NSMutableData = NSMutableData()
    
    //默认隐藏第三组，根据角色筛选显示改组
    @IBOutlet weak var thirdBackground: UIImageView!
    @IBOutlet weak var thirdLine: UIImageView!
    //此两组信息需要根据不同角色显示不同的内容
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    var rolePickerView: RolePickerView?
    var inspectionPickerView: InspectionPickerView?
    
    @IBAction func userRegisterBtn(_ sender: UIButton) {
        print("执行调用注册接口\n")
        print("角色：\(String(describing: userRole.text))\n用户：\(String(describing: userName.text))\n电话：\(String(describing: userPhone.text))")
        //设置视图适配
        let users = User()
        users.userName = userName.text
        users.userPhone = userPhone.text
        users.userRole = userRole.text
        users.userJobnum = thirdTextField.text
        //进行跳转
//        self.performSegue(withIdentifier: "login", sender: users)
        
        //调用注册接口
        let md = NSMutableDictionary()
        let network = BaseNetwork()
        var result:String = "Null"
        var registerURL:String!
        var uuid:String = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        uuid = uuid.replacingOccurrences(of: "-", with: "")
//        print("UUID=\(uuid)")
//        print("Role=\(users.userRole)")
        if users.userRole as String == "维保单位" {
            registerURL = "{\"txcode\":\"\(CommonData.TXCODE_LOGIN)\",\"imei\":\"\(uuid)\","
                            + "\"tel\":\"\(users.userPhone as String)\","
                            + "\"name\":\"\(users.userName as String)\","
                            + "\"jobnum\":\"\(users.userJobnum as String)\"}"
            md.setValue(registerURL, forKey: "data")
            network.post(url: "http://202.102.108.167:18082/njlift/android/process.action", params: md)
//            network.post(url: CommonData.CONSTANT_PATH_POST, params: md)
            
        }else if users.userRole as String == "保险公司" || users.userRole as String == "使用单位" {
            registerURL = "{\"txcode\":\"register\",\"imei\":\"\(uuid)\","
                            + "\"tel\":\"\(users.userPhone as String)\","
                            + "\"name\":\"\(users.userName as String)\","
                            + "\"deptType\":\"1\",\"roleType\":\"1\"}"
            md.setValue(registerURL, forKey: "data")
            network.post(url: "http://njdt.njtjy.org.cn:10011/njliftMaint/android/process.action", params: md)
//            network.post(url: CommonData.CONSTANT_PATH_POST_MAINT, params: md)
        }else{
            print("当前userRole的值是非现有的值，故不执行http请求！")
            print("-----End------")
        }

        let time: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            result = network.getReturnValue()
            let dic:NSDictionary = self.getDictionaryFromJSONString(jsonString: result)
            for (key,value) in dic {
                print("键：\(key),值：\(value)")
            }
        }
        
        //注册按钮设置不可用
        registerBtn.isUserInteractionEnabled = false
        registerBtn.alpha = 0.4
        let toast = ToastView()
        toast.showToast(text: "注册成功，请联系公司管理员认领！", pos: .Bottom)
    }
    
    //在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let controller = segue.destination as! LoginDoneViewController
            controller.users = (sender as? User)!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置手机号行只能数字
        userPhone.keyboardType = UIKeyboardType.namePhonePad
        //执行隐藏第三组列表
        thirdLine.isHidden = true
        thirdBackground.isHidden = true
        thirdIcon.isHidden = true
        thirdTextField.isHidden = true
        
        userRole.text = "请选择角色"
        userRole.allowsEditingTextAttributes = false
        
        rolePickerView = RolePickerView.rolepicker(for: self, textField: userRole)
        userRole.delegate = self
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(tapGR:)))
        tapGR.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGR)
//        InspectionPickerView.inspectionpicker(for: self, textField: userRole)
        
        
    }
    @objc func viewDidTap(tapGR: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - lazy
    lazy var myRole: Role = {
        return Role()
    }()
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        rolePickerView?.shouldSelected(proName: myRole.first, cityName: myRole.second, areaName: myRole.area)
    }
}

extension RegisterViewController: RolePickerDelegate {
    
    
    internal func cancel(roleToolbar: RoleToolbar, textField: UITextField, role: Role, item: UIBarButtonItem) {
//        print("点击了取消")
        if(role.first.isEmpty){
            //do nothing
        }
    }
    
    internal func sure(roleToolbar: RoleToolbar, textField: UITextField, role: Role, item: UIBarButtonItem) {
//        print("点击了确定")
//        print("最后的值是")
        if(role.first.isEmpty){
            userRole.text = "维保单位"
            role.first = "维保单位"
            print("role.first is null, and role.first is already reset default value.")
        }else{
            userRole.text = role.first
//            print("选择的角色是:\(role.first)")
        }
        
        switch role.first {
        case "维保单位":
            thirdLine.isHidden = false
            thirdBackground.isHidden = false
            thirdIcon.isHidden = false
            thirdTextField.isHidden = false
            thirdIcon.image = UIImage(named:"icon_register_zyz")
            thirdTextField.text = ""
            thirdTextField.placeholder = "请输入作业证号"
            thirdTextField.textColor = UIColor.black
        case "保险公司":
            thirdLine.isHidden = false
            thirdBackground.isHidden = false
            thirdIcon.isHidden = false
            thirdTextField.isHidden = false
            thirdIcon.image = UIImage(named:"icon_inspectper")
            thirdTextField.text = role.second
            thirdTextField.textColor = UIColor.white
            thirdTextField.isUserInteractionEnabled = false
            //print("\(role.first)的子项是：\(role.second)")
        case "非检验机构":
            thirdLine.isHidden = false
            thirdBackground.isHidden = false
            thirdIcon.isHidden = false
            thirdTextField.isHidden = false
            thirdIcon.image = UIImage(named:"icon_register_zyz")
            thirdTextField.text = ""
            thirdTextField.placeholder = "请输入作业证号"
            thirdTextField.textColor = UIColor.black
        case "检验机构":
            thirdLine.isHidden = false
            thirdBackground.isHidden = false
            thirdIcon.isHidden = false
            thirdTextField.isHidden = false
            thirdIcon.image = UIImage(named:"icon_inspectper")
            thirdTextField.text = "检验机构"
            thirdTextField.textColor = UIColor.white
            
            
            //启动选择器
//            rolePickerView = RolePickerView.picker(for: self, textField: thirdTextField)
//            thirdTextField.delegate = self
//            insurerPickerView = InsurerPickerView.picker(for: self, textField: thirdTextField)
            
            //为了点击空白的时候能够退键盘
//            let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(tapGR:)))
//            tapGR1.cancelsTouchesInView = false
//            view.addGestureRecognizer(tapGR1)
        case "使用单位":
            thirdTextField.adjustsFontSizeToFitWidth = true
            thirdLine.isHidden = true
            thirdBackground.isHidden = true
            thirdIcon.isHidden = true
            thirdTextField.isHidden = true
            
        default:
            break
        }
    }
    
    internal func statusChanged(rolePickerView: RolePickerView, pickerView: UIPickerView, textField: UITextField, role: Role) {
        //立即显示新值
        //        print("转到的值:\n")
        //        locate.decription()
//        if !role.area.isEmpty {
//            textField.text = role.first
//        } else {
//            textField.text = role.first
//        }
    }
    
}
