//
//  MyMaintViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/2/26.
//  Copyright © 2018年 尹浩. All rights reserved.
//  这个类以及废弃 -- 2018/3/20

import UIKit

class MyMaintViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red:0,green:0.58,blue:0.475,alpha:1.0)
        // 设置标题
        let titleL = UILabel()
        titleL.text = "南京电梯"
        titleL.textColor = UIColor.white
        titleL.textAlignment = NSTextAlignment.natural
        titleL.font = UIFont.systemFont(ofSize: 17)
        titleL.sizeToFit()
        self.navigationItem.titleView = titleL
        //        self.navigationItem.title = "南京电梯"
        let item=UIBarButtonItem(title: "≡", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem=item
        
        let imageView = UIImageView(image:UIImage(named:"icon_empty"))
        imageView.frame = CGRect(x:144, y:275, width:92, height:91)
        self.view.addSubview(imageView)
        let resuceTaskLabel = UILabel(frame:CGRect(x:120, y:362, width:160, height:30))
        resuceTaskLabel.text = "当前没有维保记录..."
        let textFont = UIFont(name: "", size : 7)
        let tmpColor = UIColor(red:0.8,green:0.8,blue:0.8,alpha:1.0)
        resuceTaskLabel.font = textFont
        resuceTaskLabel.textColor = tmpColor
        self.view.addSubview(resuceTaskLabel);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

