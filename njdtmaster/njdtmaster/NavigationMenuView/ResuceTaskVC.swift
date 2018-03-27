//
//  ResuceTaskViewController.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by 尹浩 on 2018/3/12.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ResuceTaskVC: UIViewController {
    
    var rescode:String = "0"
    var msg:String = ""
    let timeVal: TimeInterval = 3
    let toast = ToastView()
    var dataArray = [Dictionary<String, String>]()
    
    static let ROOTTABLEVIEWCELLIDENTIFIER = "ROOTTABLEVIEWCELLIDENTIFIER"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.toast.getLoadingDlg()
        
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
        
        //调用救援任务(维保单位)数据接口
        Alamofire.request(CommonData.CONSTANT_PATH_POST, method: .post, parameters: ["data":"{\"txcode\":\"\(CommonData.TXCODE_PENDING_FORM)\",\"maintId\":\"\(CommonData.MAINT_ID)\",\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    //print("登陆验证反馈信息：\(value)")
                    let json = JSON(value)
//                    print(value)
                    self.rescode = json["rescode"].string!
                    self.msg = json["msg"].string!
                    let time: TimeInterval = 2.3
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                        //print("2 秒后输出")
                        if self.rescode == "1" {
                            print("获取失败，原因是：\(self.msg)")
//                            let toast = ToastView()
//                            toast.showToast(text: "已经注册！请联系公司管理员认领！", pos: .Bottom)
                            
                        }else if self.rescode == "0"{
                            print("获取成功，原因是：\(self.msg)")
                            var resuceData:Dictionary = Dictionary<String,String>()
                            //print(json["data"][0]["LIFTIDCODE"].string!)
                            //print(json["data"][0]["LATITUDE"].int!)
                            resuceData["title"] = json["data"][0]["LIFTIDCODE"].string!
                            resuceData["date"] = json["data"][0]["FORMCREATETIME"].string!
                            resuceData["company"] = json["data"][0]["LIFTUSER"].string!
                            resuceData["address"] = json["data"][0]["LIFTADD"].string!
                            resuceData["lat"] = "\(json["data"][0]["LATITUDE"].double!)"
                            resuceData["lng"] = "\(json["data"][0]["LONGITUDE"].double!)"
                            resuceData["formid"] = json["data"][0]["FORMID"].string!
                            self.dataArray.append(resuceData)
                        }else if self.rescode == "2"{
                            print("获取失败，原因是：\(self.msg)")
                            //登陆失败，将跳转至注册页面
                        }
                    }
                }else{
                    print(response.result.value!)
                }
            case false:
                print("调用登陆接口发生错误")
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.timeVal) {
                self.view.addSubview(self.rootTableView)
            }
            self.toast.showFinished(sender: self)
        }
        
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
        var tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"MyTableViewCell", bundle:nil),
                           forCellReuseIdentifier:"myCell")
        return tableView
        }()
   
}

// MARK -- TableView Delegate
extension ResuceTaskVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell")
            as! MyTableViewCell
        let item = self.dataArray[indexPath.row]
        cell.customTitleLabel.text = item["title"]
        cell.customDateLabel.text = item["date"]
        cell.customCompanyLabel.text = item["company"]
        cell.customAddressLabel.text = item["address"]
        cell.customImage.image = UIImage(named: "icon_callout")
        cell.customImage.isUserInteractionEnabled = true
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        cell.customImage?.addGestureRecognizer(singleTapGesture)
        cell.customImage?.isUserInteractionEnabled = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resuceMapVC = ResuceMapViewController()
        resuceMapVC.title = "救援路线"
        resuceMapVC.dataDetail = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(resuceMapVC, animated: true)
    }
    
    @objc func imageViewClick(sender:UITapGestureRecognizer) {
        print("开始拨号")
        //自动打开拨号页面并自动拨打电话
        let urlString = "tel://96333"
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        //执行上传到达现场距离（接口 uploadArrive）
        //todo
    }
}



