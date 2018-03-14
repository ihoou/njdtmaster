//
//  SideViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/13.
//  Copyright © 2018年 尹浩. All rights reserved.
//  侧边菜单视图
//

import UIKit
import Alamofire
import SwiftyJSON

class SideViewController: UIViewController {
    
    static let TABLEVIEWCELLIDENTIFIER = "TABLEVIEWCELLIDENTIFIER"
    let titleArray = ["我的信息", "我的排名", "公告信息", "维保统计"]
    let imageArray = ["icon_side_sound", "icon_side_trophy", "icon_side_info", "icon_side_chart"]
    
    var weatherDic:NSMutableDictionary = ["weatherDate":"","weatherInfo":"","weatherTemperature":"","weatherImgURL":"http://api.map.baidu.com/images/weather/day/duoyun.png"]
    var weatherDATE:String = ""
    var weatherINFO:String = ""
    var weatherTEMPERATURE:String = ""
    var imgURL:String = "http://api.map.baidu.com/images/weather/day/duoyun.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(backImage)
        view.addSubview(rootTableView)
    }
    
    lazy var backImage : UIImageView = { [unowned self] in
        var image = UIImageView(image: UIImage(named: "bg_register"))
        image.frame = self.view.bounds
        image.alpha = 0.85
        return image
        }()
    
    lazy var rootTableView : UITableView = { [unowned self] in
        var tableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: SideViewController.TABLEVIEWCELLIDENTIFIER)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        }()
    
}

extension SideViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideViewController.TABLEVIEWCELLIDENTIFIER, for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.imageView?.image = UIImage(named: imageArray[indexPath.row])
        
        
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.backgroundColor = .clear
        headView.alpha = 1
        
        //调用天气接口
        getWeatherData()
        let time: TimeInterval = 1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            let dateLabel = UILabel()
            let weatherLabel = UILabel()
            let temperatureLabel = UILabel()
            for (key,value) in self.weatherDic{
//                print("key=\(key),value=\(value)")
                if "weatherDate".contains(key as! String) {
                    dateLabel.text = value as? String
                }else{
                    //print("不是weather,\(key),\(value)")
                }
                if "weatherInfo".contains(key as! String) {
                    weatherLabel.text = value as? String
                }else{
                    //print("不是weatherInfo,\(key),\(value)")
                }
                if "weatherTemperature".contains(key as! String) {
                    temperatureLabel.text = value as? String
                }else{
                    //print("不是weatherTemperature,\(key),\(value)")
                }
                if "weatherImgURL".contains(key as! String) {
                    self.imgURL = value as! String
                }else{
                    //print("不是weatherImgURL,\(key),\(value)")
                }
            }
            let authorImage = UIImageView(image: UIImage(named: "11"))
            authorImage.frame = CGRect(x:12,y:56,width:64,height:64)
            headView.addSubview(authorImage)
            let url = URL(string: self.imgURL)
            let data = try! Data(contentsOf: url!)
            let weatherImageView = UIImageView(image: UIImage(data: data))
            dateLabel.frame = CGRect(x: 90, y: 60, width: 170, height: 30)
            weatherLabel.frame = CGRect(x: 112, y: 90, width: 100, height: 30)
            temperatureLabel.frame = CGRect(x: 180, y: 90, width: 60, height: 30)
            weatherImageView.frame = CGRect(x: 90, y:94, width: 20,height: 20)
            dateLabel.textAlignment = NSTextAlignment.left
            weatherLabel.textAlignment = NSTextAlignment.left
            temperatureLabel.textAlignment = NSTextAlignment.left
            dateLabel.font = UIFont.systemFont(ofSize: 13)
            weatherLabel.font = UIFont.systemFont(ofSize: 12)
            temperatureLabel.font = UIFont.systemFont(ofSize: 12)
            let str:String = weatherLabel.text!
            if str.count > 7 {//判断天气信息字符串过长时，缩小字体以及调整温度Label水平位置
                weatherLabel.font = UIFont.systemFont(ofSize:10)
                temperatureLabel.frame = CGRect(x: 200, y: 90, width: 60, height: 30)
            }
            dateLabel.numberOfLines = 0
            weatherLabel.numberOfLines = 0
            temperatureLabel.numberOfLines = 0
            dateLabel.textColor = .white
            weatherLabel.textColor = .white
            temperatureLabel.textColor = .white
            dateLabel.backgroundColor = .clear
            weatherLabel.backgroundColor = .clear
            temperatureLabel.backgroundColor = .clear
            headView.addSubview(dateLabel)
            headView.addSubview(weatherLabel)
            headView.addSubview(temperatureLabel)
            headView.addSubview(weatherImageView)
    
        }
        return headView
    }
    
    //调用天气接口
    func getWeatherData(){
//        print("开始调用百度天气接口...")
        Alamofire.request(CommonData.WEATHER_PATH, method: .get, parameters: ["location":"南京","output":"json","ak":"6tYzTvGZSOpYB5Oc2YGGOKt8"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
//                    print(json)
//                    print(json["date"])
//                    print(json["results"][0]["weather_data"][0]["weather"])//天气
//                    print(json["results"][0]["weather_data"][0]["temperature"])//温度
//                    print(json["results"][0]["weather_data"][0]["dayPictureUrl"])//天气图标
                    //print(json["results"][0]["weather_data"][0]["wind"])//风力
                    //print(json["results"][0]["index"][0]["tipt"])//穿衣指数
                    //print(json["results"][0]["index"][0]["des"])//穿衣指数描述
                    self.weatherDic["weatherDate"] = json["results"][0]["weather_data"][0]["date"].string!
                    self.weatherDic["weatherInfo"] = json["results"][0]["weather_data"][0]["weather"].string!
                    self.weatherDic["weatherTemperature"] = json["results"][0]["weather_data"][0]["temperature"].string!
                    self.weatherDic["weatherImgURL"] = json["results"][0]["weather_data"][0]["dayPictureUrl"].string!
//                    print("天气接口调用完成...")
                }
            case false:
                print("调用天气接口发生错误：\(response.result.error as Any)")
            }
        }
//        print(self.weatherDic)
//        return self.weatherDic
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegate  = UIApplication.shared.delegate! as! AppDelegate
        let rootVC = delegate.window?.rootViewController as! XYSideViewControllerSwift
        rootVC.closeSideVC()
//        let otherVC = OtherViewController()
//        otherVC.title = titleArray[indexPath.row]
//        rootVC.currentNavController?.pushViewController(otherVC, animated: true)
//        print("\(String(describing: otherVC.title))：页面")
        switch indexPath.row {
        case 0:
            let noticsInfoVC = NoticeInfoSubVC()
            noticsInfoVC.title = titleArray[indexPath.row]
            rootVC.currentNavController?.pushViewController(noticsInfoVC, animated: true)
            print("\(String(describing: noticsInfoVC.title!))子页面")
        case 1:
            let myRanksVC = MyRanksSubVC()
            myRanksVC.title = titleArray[indexPath.row]
            rootVC.currentNavController?.pushViewController(myRanksVC, animated: true)
            print("\(String(describing: myRanksVC.title!))子页面")
        case 2:
            let myInfoVC = MyInfoSubVC()
            myInfoVC.title = titleArray[indexPath.row]
            rootVC.currentNavController?.pushViewController(myInfoVC, animated: true)
            print("\(String(describing: myInfoVC.title!))子页面")
        case 3:
            let maintenanceStatisticsVC = MaintenanceStatisticsSubVC()
            maintenanceStatisticsVC.title = titleArray[indexPath.row]
            rootVC.currentNavController?.pushViewController(maintenanceStatisticsVC, animated: true)
            print("\(String(describing: maintenanceStatisticsVC.title!))子页面")
        default:
            print("错误菜单选项")
        }
        
    }
}

