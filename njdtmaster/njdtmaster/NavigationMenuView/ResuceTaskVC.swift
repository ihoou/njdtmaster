//
//  ResuceTaskViewController.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by 尹浩 on 2018/3/12.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

import UIKit

class ResuceTaskVC: UIViewController {
    
    static let ROOTTABLEVIEWCELLIDENTIFIER = "ROOTTABLEVIEWCELLIDENTIFIER"
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "救援任务"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red:0,green:0.58,blue:0.475,alpha:1.0)
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)//titile为空，只显示向左箭头
        item.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = item
        // 设置标题
        let titleL = UILabel()
        titleL.text = "南京电梯"
        titleL.textColor = UIColor.white
        titleL.textAlignment = NSTextAlignment.natural
        titleL.font=UIFont.boldSystemFont(ofSize: 17)
        titleL.sizeToFit()
        self.navigationItem.titleView = titleL
        
//        let menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        menuBtn.setImage(#imageLiteral(resourceName: "side_menu"), for: .normal)
//        menuBtn.addTarget(self, action:#selector(openSideMenu), for:.touchUpInside)
//        let leftBtn = UIBarButtonItem(customView: menuBtn)
//        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        negativeSpacer.width = -15
//        navigationItem.leftBarButtonItems = [negativeSpacer, leftBtn]
        
//        view.addSubview(rootTableView)
    }
    @objc func openSideMenu(){
        print("展开侧边菜单")
        //TODO
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var rootTableView : UITableView = { [unowned self] in
        var tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: ResuceTaskVC.ROOTTABLEVIEWCELLIDENTIFIER)
        return tableView
    }()
    lazy var titleArray : [String] = {
        var array = ["救援任务一", "救援任务一", "救援任务一", "救援任务一", "救援任务一", "救援任务一"]
        return array
    }()
    let imageArray : [String] = {
        let array = ["haidi", "haidi", "haidi", "haidi", "haidi", "haidi"]
        return array
    }()
}

// MARK -- TableView Delegate
extension ResuceTaskVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResuceTaskVC.ROOTTABLEVIEWCELLIDENTIFIER, for: indexPath)
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.detailTextLabel?.text = "2018-03-22 09:15:20"
        let idCode:UILabel = cell.viewWithTag(1101) as! UILabel!
        let date:UILabel = cell.viewWithTag(1102) as! UILabel!
        let company:UILabel = cell.viewWithTag(1103) as! UILabel!
        let address:UILabel = cell.viewWithTag(1104) as! UILabel!
        
        cell.imageView?.image = UIImage(named: self.imageArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let otherVC = OtherViewController()
        otherVC.title = titleArray[indexPath.row]
        self.navigationController?.pushViewController(otherVC, animated: true)
    }
}



