//
//  ResuceMapViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/27.
//  Copyright © 2018年 尹浩. All rights reserved.
//  救援路线地图

import UIKit

class ResuceMapViewController: UIViewController {
    var dataDetail:Dictionary = Dictionary<String,String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(dataDetail["lat"]!)
        print(dataDetail["lng"]!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
}
