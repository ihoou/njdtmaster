//
//  MainTabViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/2/26.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

class MainTabViewController:UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //设置导航样式
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundImage = UIImage(named:"bg_tabbar")
        self.tabBar.tintColor = UIColor.white
//        self.view.backgroundColor = UIColor.green
        
        //一共包含了四个视图
        let viewResuceTask = ResuceTaskViewController()
        viewResuceTask.title = "救援任务"
        let viewMyResuce = MyResuceViewController()
        viewMyResuce.title = "我的救援"
        let viewMaintPlan = MaintPlanViewController()
        viewMaintPlan.title = "维保计划"
        let viewMyMaint = MyMaintViewController()
        viewMyMaint.title = "我的维保"
        
        //分别声明四个视图控制器
        let resuceTask = UINavigationController(rootViewController:viewResuceTask)
        resuceTask.tabBarItem.image = UIImage(named:"icon_task_normal")
        resuceTask.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);//设置图标位置
        resuceTask.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -6)//设置标题文字位置
        
        //定义tab按钮添加个badge小红点值
        //        resuceTask.tabBarItem.badgeValue = "!"
        
        let myResuce = UINavigationController(rootViewController:viewMyResuce)
        myResuce.tabBarItem.image = UIImage(named:"icon_rescue_normal")
        myResuce.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
        myResuce.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -6)
        
        self.viewControllers = [resuceTask,myResuce]
        
        let maintPlan = UINavigationController(rootViewController:viewMaintPlan)
        maintPlan.tabBarItem.image = UIImage(named:"icon_setting_normal")
        maintPlan.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
        maintPlan.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -6)
        self.viewControllers = [resuceTask,myResuce,maintPlan]
        
        let myMaint = UINavigationController(rootViewController:viewMyMaint)
        myMaint.tabBarItem.image = UIImage(named:"icon_rank_normal")
        myMaint.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
        myMaint.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -6)
        self.viewControllers = [resuceTask,myResuce,maintPlan,myMaint]
        
        
        //默认选中的是救援任务主界面视图
        self.selectedIndex = 0
    }
}

