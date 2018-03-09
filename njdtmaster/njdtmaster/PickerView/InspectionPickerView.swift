//
//  InspectionPickerView.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/29.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

let stKey = "state"
let ciKey = "cities"
let cyKey = "city"
let arKey = "areas"

let APBarTintColor = UIColor(red: 60/255, green: 226/255, blue: 208/255, alpha: 1.0)
let APTintColor = UIColor.white
///屏幕宽度
let AP_WIDTH: CGFloat = {
    UIScreen.main.bounds.size.width
}()

enum InspectionPickerType: Int {
    case first
    case second
    case area
}

protocol InspectionPickerViewDelegate: class {
    func statusChanged(inspectionPickerView: InspectionPickerView, pickerView: UIPickerView, textField: UITextField, inspection: Inspection)
}

protocol InspectionPickerDelegate: InspectionPickerViewDelegate, InspectionToolbarDelegate {}

class InspectionPickerView: UIView {
    
    var cities = [[String: AnyObject]]()
    var areas = [String]()
    var textField: UITextField!
    var pickerView:UIPickerView!
    var toolbar: InspectionToolbar!
    
    weak var mydelegate: InspectionPickerViewDelegate?
    
    static func inspectionpicker<Mycontroller: UIViewController>(for controller: Mycontroller, textField: UITextField, barTintColor: UIColor = APBarTintColor, tintColor: UIColor = APTintColor) -> InspectionPickerView where Mycontroller: InspectionPickerDelegate {
        
        
        let inspectionPickerView = InspectionPickerView()
        inspectionPickerView.mydelegate = controller
        inspectionPickerView.textField = textField
        
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        inspectionPickerView.pickerView = pickerView
        
        pickerView.delegate = inspectionPickerView
        pickerView.dataSource = inspectionPickerView
        
        inspectionPickerView.cities = inspectionPickerView.inspectionlists[0][ciKey] as! [[String : AnyObject]]!
        if let province = inspectionPickerView.inspectionlists[0][stKey] as? String {
            inspectionPickerView.inspectionsource.first = province
        }
        
        if let second = inspectionPickerView.cities[0][cyKey] as? String {
            inspectionPickerView.inspectionsource.second = second
        }
        
        
        inspectionPickerView.areas = inspectionPickerView.cities[0][arKey] as! [String]!
        
        if inspectionPickerView.areas.count > 0 {
            inspectionPickerView.inspectionsource.area = inspectionPickerView.areas[0]
        } else {
            inspectionPickerView.inspectionsource.area = ""
        }
        
        textField.inputView = pickerView
        inspectionPickerView.toolbar = InspectionToolbar.bar(for: controller, textField: textField, barTintColor: APBarTintColor, tintColor: APTintColor)
        textField.inputAccessoryView = inspectionPickerView.toolbar
        
        
        return inspectionPickerView
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
        
        for index in 0..<inspectionlists.count {
            let pro = inspectionlists[index]
            if pro[stKey] as! String == proName {
                cities = inspectionlists[index][ciKey] as! [[String : AnyObject]]!
                if let first = inspectionlists[index][stKey] as? String {
                    inspectionsource.first = first
                }
                pickerView.selectRow(index, inComponent: InspectionPickerType.first.rawValue, animated: false)
                break
            }
        }
        
        for index in 0..<cities.count {
            let second = cities[index]
            if second[cyKey] as! String == cityName {
                if let second = cities[index][cyKey] as? String {
                    inspectionsource.second = second
                }
                
                areas = cities[index][arKey] as! [String]!
                pickerView.selectRow(index, inComponent: InspectionPickerType.second.rawValue, animated: false)
                break
            }
        }
        
        if areaName != nil {
            
            for (index, name) in areas.enumerated() {
                if name == areaName! {
                    inspectionsource.area = areas[index]
                    pickerView.selectRow(index, inComponent: InspectionPickerType.area.rawValue, animated: false)
                    break
                }
            }
        }
        
    }
    
    
    // MARK: - lazy
    lazy var inspectionlists: [[String: AnyObject]] = {
        let path = Bundle.main.path(forResource: "inspection", ofType: "plist")
        return NSArray(contentsOfFile: path!) as! [[String: AnyObject]]
    }()
    
    lazy var inspectionsource: Inspection = {
        return Inspection()
    }()
    
}

extension InspectionPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let pickerType = InspectionPickerType(rawValue: component)!
        switch pickerType {
        case .first:
            return inspectionlists.count
        case .second:
            return cities.count
        case .area:
            return areas.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerType = InspectionPickerType(rawValue: component)!
        switch pickerType {
        case .first:
            return inspectionlists[row][stKey] as! String?
        case .second:
            return cities[row][cyKey] as! String?
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
            
            cities = inspectionlists[row][ciKey] as! [[String : AnyObject]]!
            pickerView.reloadComponent(PickerType.second.rawValue)
            pickerView.selectRow(0, inComponent: PickerType.second.rawValue, animated: true)
            reloadAreaComponent(pickerView: pickerView, row: 0)
            if let first = inspectionlists[row][stKey] as? String {
                inspectionsource.first = first
            }
            print("当前选中的是：\(inspectionsource.first)")
            
        case .second:
            reloadAreaComponent(pickerView: pickerView, row: row)
        case .area:
            if areas.count > 0 {
                inspectionsource.area = areas[row]
            } else {
                inspectionsource.area = ""
            }
        }
        
        toolbar.inspection = inspectionsource
        mydelegate?.statusChanged(inspectionPickerView: self, pickerView: pickerView, textField: textField, inspection: inspectionsource)
        
    }
    
    func reloadAreaComponent(pickerView: UIPickerView, row: Int) {
        
        
        guard row <= cities.count - 1 else {
            return
        }
        
        areas = cities[row][arKey] as! [String]!
        pickerView.reloadComponent(PickerType.area.rawValue)
        pickerView.selectRow(0, inComponent: PickerType.area.rawValue, animated: true)
        
        if let second = cities[row][cyKey] as? String {
            inspectionsource.second = second
        }
        if areas.count > 0 {
            inspectionsource.area = areas[0]
        } else {
            inspectionsource.area = ""
        }
        
    }
}
