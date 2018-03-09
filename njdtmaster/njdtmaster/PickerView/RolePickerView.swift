//
//  AreaPickerView.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/17.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

let stateKey = "state"
let citiesKey = "cities"
let cityKey = "city"
let areasKey = "areas"

let APDefaultBarTintColor = UIColor(red: 60/255, green: 226/255, blue: 208/255, alpha: 1.0)
let APDefaultTintColor = UIColor.white
///屏幕宽度
let APMAIN_WIDTH: CGFloat = {
    UIScreen.main.bounds.size.width
}()

enum PickerType: Int {
    case first
    case second
    case area
}

protocol RolePickerViewDelegate: class {
    func statusChanged(rolePickerView: RolePickerView, pickerView: UIPickerView, textField: UITextField, role: Role)
}

protocol RolePickerDelegate: RolePickerViewDelegate, RoleToolbarDelegate {}

class RolePickerView: UIView {
    
    var cities = [[String: AnyObject]]()
    var areas = [String]()
    var textField: UITextField!
    var pickerView:UIPickerView!
    var toolbar: RoleToolbar!
    
    
    weak var delegate: RolePickerViewDelegate?
    
    static func rolepicker<controller: UIViewController>(for controller: controller, textField: UITextField, barTintColor: UIColor = APDefaultBarTintColor, tintColor: UIColor = APDefaultTintColor) -> RolePickerView where controller: RolePickerDelegate {
        //        print("the vaule is \(String(describing: textField.text))")
    
        
        let rolePickerView = RolePickerView()
        rolePickerView.delegate = controller
        rolePickerView.textField = textField
        
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        rolePickerView.pickerView = pickerView
        
        pickerView.delegate = rolePickerView
        pickerView.dataSource = rolePickerView
        
        rolePickerView.cities = rolePickerView.rolelists[0][citiesKey] as! [[String : AnyObject]]!
        if let province = rolePickerView.rolelists[0][stateKey] as? String {
            rolePickerView.rolesource.first = province
        }
        
        if let second = rolePickerView.cities[0][cityKey] as? String {
            rolePickerView.rolesource.second = second
        }
        
        
        rolePickerView.areas = rolePickerView.cities[0][areasKey] as! [String]!
        
        if rolePickerView.areas.count > 0 {
            rolePickerView.rolesource.area = rolePickerView.areas[0]
        } else {
            rolePickerView.rolesource.area = ""
        }
        
        textField.inputView = pickerView
        rolePickerView.toolbar = RoleToolbar.bar(for: controller, textField: textField, barTintColor: APDefaultBarTintColor, tintColor: APDefaultTintColor)
        textField.inputAccessoryView = rolePickerView.toolbar
        
        
        return rolePickerView
    }
    
    private init(){
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    deinit {
    //        print("地址选择器被销毁")
    //    }
    
    func shouldSelected(proName: String, cityName: String, areaName: String?) {
        
        for index in 0..<rolelists.count {
            let pro = rolelists[index]
            if pro[stateKey] as! String == proName {
                cities = rolelists[index][citiesKey] as! [[String : AnyObject]]!
                if let first = rolelists[index][stateKey] as? String {
                    rolesource.first = first
                }
                pickerView.selectRow(index, inComponent: PickerType.first.rawValue, animated: false)
                break
            }
        }
        
        for index in 0..<cities.count {
            let second = cities[index]
            if second[cityKey] as! String == cityName {
                if let second = cities[index][cityKey] as? String {
                    rolesource.second = second
                }
                
                areas = cities[index][areasKey] as! [String]!
                pickerView.selectRow(index, inComponent: PickerType.second.rawValue, animated: false)
                break
            }
        }
        
        if areaName != nil {
            
            for (index, name) in areas.enumerated() {
                if name == areaName! {
                    rolesource.area = areas[index]
                    pickerView.selectRow(index, inComponent: PickerType.area.rawValue, animated: false)
                    break
                }
            }
        }
        
    }
    
    
    // MARK: - lazy
    lazy var rolelists: [[String: AnyObject]] = {
        let path = Bundle.main.path(forResource: "role", ofType: "plist")
        return NSArray(contentsOfFile: path!) as! [[String: AnyObject]]
    }()
    
    lazy var rolesource: Role = {
        return Role()
    }()
    
    func taylorSwift(){
        print("Taylor Swift")
    }
    
}

extension RolePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let pickerType = PickerType(rawValue: component)!
        switch pickerType {
        case .first:
            return rolelists.count
        case .second:
            return cities.count
        case .area:
            return areas.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerType = PickerType(rawValue: component)!
        switch pickerType {
        case .first:
            return rolelists[row][stateKey] as! String?
        case .second:
            return cities[row][cityKey] as! String?
        case .area:
            if areas.count > 0 {
                return areas[row]
            } else {
                return ""
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        print("选中了某一行")
        let pickerType = PickerType(rawValue: component)!
        switch pickerType {
        case .first:
            
            cities = rolelists[row][citiesKey] as! [[String : AnyObject]]!
            pickerView.reloadComponent(PickerType.second.rawValue)
            pickerView.selectRow(0, inComponent: PickerType.second.rawValue, animated: true)
            reloadAreaComponent(pickerView: pickerView, row: 0)
            if let first = rolelists[row][stateKey] as? String {
                rolesource.first = first
            }
//            print("当前选中的是：\(rolesource.first)")
            
        case .second:
            reloadAreaComponent(pickerView: pickerView, row: row)
        case .area:
            if areas.count > 0 {
                rolesource.area = areas[row]
            } else {
                rolesource.area = ""
            }
        }
        
        toolbar.role = rolesource
        delegate?.statusChanged(rolePickerView: self, pickerView: pickerView, textField: textField, role: rolesource)
        
    }
    
    func reloadAreaComponent(pickerView: UIPickerView, row: Int) {
        
        
        guard row <= cities.count - 1 else {
            return
        }
        
        areas = cities[row][areasKey] as! [String]!
        pickerView.reloadComponent(PickerType.area.rawValue)
        pickerView.selectRow(0, inComponent: PickerType.area.rawValue, animated: true)
        
        if let second = cities[row][cityKey] as? String {
            rolesource.second = second
        }
        if areas.count > 0 {
            rolesource.area = areas[0]
        } else {
            rolesource.area = ""
        }
        
    }
}
