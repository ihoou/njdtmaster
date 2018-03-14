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
    
    var weatherDic:NSMutableDictionary = ["weatherDate":"","weatherInfo":"","weatherTemperature":"","weatherImgURL":""]
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
        let time: TimeInterval = 2
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            let dateLabel = UILabel()
            let weatherLabel = UILabel()
            let temperatureLabel = UILabel()
            let url = URL(string: self.imgURL)
            for (key,value) in self.weatherDic{
//                print("\(key),\(value)")
                if "weatherDate".hasPrefix(key as! String) {
                    dateLabel.text = value as? String
                }else{
                    print("\(key),\(value)")
                }
                if key as! String == "weatherInfo" as String {
                    weatherLabel.text = value as? String
                }else{
                    print("\(key),\(value)")
                }
                if key as! String == "weatherTemperature" as String {
                    temperatureLabel.text = value as? String
                }else{
                    print("\(key),\(value)")
                }
                if key as! String == "weatherImgURL" as String {
                    //self.imgURL = value as! String
                }else{
                    print("\(key),\(value)")
                }
            }
            let authorImage = UIImageView(image: UIImage(named: "11"))
            authorImage.frame = CGRect(x:12,y:56,width:64,height:64)
            headView.addSubview(authorImage)
            let data = try! Data(contentsOf: url!)
            let weatherImageView = UIImageView(image: UIImage(data: data))
            dateLabel.frame = CGRect(x: 90, y: 60, width: 150, height: 30)
            weatherLabel.frame = CGRect(x: 112, y: 90, width: 100, height: 30)
            temperatureLabel.frame = CGRect(x: 200, y: 90, width: 60, height: 30)
            weatherImageView.frame = CGRect(x: 90, y:94, width: 20,height: 20)
            dateLabel.textAlignment = NSTextAlignment.left
            weatherLabel.textAlignment = NSTextAlignment.left
            temperatureLabel.textAlignment = NSTextAlignment.left
            dateLabel.font = UIFont.systemFont(ofSize: 19)
            weatherLabel.font = UIFont.systemFont(ofSize: 12)
            temperatureLabel.font = UIFont.systemFont(ofSize: 12)
            dateLabel.text = "3月14号 星期三"
            weatherLabel.text = "多云"
            let str:String = weatherLabel.text!
            if str.count > 7 {
                weatherLabel.font = UIFont.systemFont(ofSize:10)
            }
            temperatureLabel.text = "25 ~ 14℃"
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
        print("开始调用百度天气接口...")
        Alamofire.request("http://api.map.baidu.com/telematics/v3/weather", method: .get, parameters: ["location":"南京","output":"json","ak":"6tYzTvGZSOpYB5Oc2YGGOKt8"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
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
                    self.weatherDic["weatherDate"] = json["results"][0]["weather_data"][0]["date"]
                    self.weatherDic["weatherInfo"] = json["results"][0]["weather_data"][0]["weather"]
                    self.weatherDic["weatherTemperature"] = json["results"][0]["weather_data"][0]["temperature"]
                    self.weatherDic["weatherImgURL"] = json["results"][0]["weather_data"][0]["dayPictureUrl"]
                    print("天气接口调用完成...")
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
        let otherVC = OtherViewController()
        otherVC.title = titleArray[indexPath.row]
        rootVC.currentNavController?.pushViewController(otherVC, animated: true)
        print("\(String(describing: otherVC.title))：页面")
    }
}

