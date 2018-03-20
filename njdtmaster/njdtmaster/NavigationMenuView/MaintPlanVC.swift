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
//        title = "维保计划"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red:0,green:0.58,blue:0.475,alpha:1.0)
        // 设置标题
        let titleL = UILabel()
        titleL.text = "南京电梯"
        titleL.textColor = UIColor.white
        titleL.textAlignment = NSTextAlignment.natural
        titleL.font=UIFont.boldSystemFont(ofSize: 17)
        titleL.sizeToFit()
        self.navigationItem.titleView = titleL
        
        setUpCustomView()
        
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


