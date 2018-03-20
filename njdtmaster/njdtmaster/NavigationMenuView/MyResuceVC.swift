//
//  SecondViewController.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by 尹浩 on 2018/3/12.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

import UIKit

class MyResuceVC: UIViewController {

    static let TABLEVIEWCELLIDENTIFIER = "TABLEVIEWCELLIDENTIFIER"
    let imageArray = ["haidi", "haidi", "haidi", "haidi", "haidi"]
    let titleArray = ["我的救援1", "我的救援2", "我的救援3", "我的救援4", "我的救援5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "我的救援"
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
        
//        setUpCustomView()
        let emptyImg = UIImage(named: "icon_empty")
        let nullIV = UIImageView(image: emptyImg)
        nullIV.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 40, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2 - 40, width:80,height:80)
//        nullIV.frame = CGRect(x:125, y:125, width:50,height:50)
        view.addSubview(nullIV)
        let desLabel = UILabel()
        desLabel.text = "当前没有救援记录..."
        desLabel.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 60, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2 + 50, width:120, height: 20)
        desLabel.adjustsFontSizeToFitWidth = true
        desLabel.textColor = UIColor.gray
        desLabel.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(desLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var rootTableView : UITableView = { [unowned self] in
       
        var tableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: MyResuceVC.TABLEVIEWCELLIDENTIFIER)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setUpCustomView() {
        view.addSubview(rootTableView)
    }
}


extension MyResuceVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyResuceVC.TABLEVIEWCELLIDENTIFIER, for: indexPath)
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

