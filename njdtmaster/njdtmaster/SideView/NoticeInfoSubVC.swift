//
//  NoticeInfoSubViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/14.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

class NoticeInfoSubVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}
