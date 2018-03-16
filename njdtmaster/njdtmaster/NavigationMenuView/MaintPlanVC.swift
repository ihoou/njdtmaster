//
//  MaintPlanViewController.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by 尹浩 on 2018/3/12.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

import UIKit

class MaintPlanVC: UIViewController {
    
    static let TABLEVIEWCELLIDENTIFIER = "TABLEVIEWCELLIDENTIFIER"
    let imageArray = ["haidi", "haidi", "haidi", "haidi", "haidi", "haidi", "haidi", "haidi"]
    let titleArray = ["测试三", "测试三", "测试三", "测试三", "测试三", "测试三", "测试三", "测试三"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "维保计划"
        view.backgroundColor = .white
        setUpCustomView()
        /*
         本周完成情况：
         南京电梯App
         1、解决天气接口数据不一致，重新整合百度天气接口，完成
         2、开发侧滑菜单--我的信息，完成
         3、解决navigationMenu与SideView兼容问题，已解决
         4、维保计划页面整合数据（接口开发），60%
         5、进行屏幕适配（iPhone X，iPhone 8以及Plus三个尺寸适配）
         6、项目已更新至GitHub：https://github.com/ihoou/njdtmaster
         
         下周计划：
         1、南京电梯App维保计划页面开发
         2、侧边菜单公告信息、维保统计开发
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var rootTableView : UITableView = { [unowned self] in
        
        var tableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: MaintPlanVC.TABLEVIEWCELLIDENTIFIER)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        }()
    
    func setUpCustomView() {
        view.addSubview(rootTableView)
    }
}


extension MaintPlanVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaintPlanVC.TABLEVIEWCELLIDENTIFIER, for: indexPath)
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.imageView?.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let otherVC = OtherViewController()
        otherVC.title = titleArray[indexPath.row]
        navigationController?.pushViewController(otherVC, animated: true)
    }
    
}


