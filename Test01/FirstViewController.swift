//
//  FirstViewController.swift
//  Test01
//
//  Created by IOS App on 17/1/27.
//  Copyright © 2017年 nova. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation


class FirstViewController: UIViewController,CLLocationManagerDelegate {
    private let key = "f1a3ae9b9f1a46908964a080c6d21cca"
    private var city:String = "beijing"
    var currLocation : CLLocation! //保存定位信息
    let locationManager : CLLocationManager = CLLocationManager()
    @IBOutlet var txtview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        
        
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied) {
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLLocationAccuracyKilometer
            locationManager.delegate = self
            locationManager.startUpdatingLocation()//开始定位
        }else {
            let aleat = UIAlertController(title: "打开定位开关", message:"定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,并允许xxx使用定位服务", preferredStyle: .alert)
            let tempAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            }
            let callAction = UIAlertAction(title: "立即设置", style: .default) { (action) in
                let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                if UIApplication.shared.canOpenURL(url! as URL) {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            aleat.addAction(tempAction)
            aleat.addAction(callAction)
            self.present(aleat, animated: true, completion: nil)
        }
    }
    
   
    
    func loadweather() {
        
        let url = "https://free-api.heweather.com/v5/now?city=\(self.city)&key=" + self.key
        print(url)
        
        Alamofire.request(url).validate().responseJSON{ response in
            
            switch response.result {
            case .success:
                let json = JSON(data:response.data!)
                
                var result = ""
                for result1 in json["HeWeather5"].arrayValue{
                    let city = result1["basic"]["city"]
                    let loc  = result1["basic"]["update"]["loc"]////当地时间
                    let txt  = result1["now"]["cond"]["txt"]//天气状况描述
                    let fl   = result1["now"]["fl"]//体感温度
                    let hum  = result1["now"]["hum"]//相对湿度（%
                    let pcpn = result1["now"]["pcpn"]//降水量（mm）
                    let tmp  = result1["now"]["tmp"] //温度
                    let vis  = result1["now"]["vis"]//能见度（km）
                    let dir  = result1["now"]["wind"]["dir"]//风向
                    let sc   = result1["now"]["wind"]["sc"]//风力
                    let spd  = result1["now"]["wind"]["spd"]//风速（kmph
                    result = result + "\n城市:\(city)\n当地时间:\(loc)\n天气:\(txt)\n体感温度:\(fl)℃\n相对湿度:\(hum)℃\n降水量:\(pcpn)mm\n温度:\(tmp)℃\n能见度:\(vis)km\n风向:\(dir)\n风力:\(sc) \n风速:\(spd)km/h\n"
                }
                self.txtview.text = result;
            case .failure:
                print("failure")
            }
        }
    }
    
    
    //MARK:CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {//定位成功
        currLocation = locations.last
        LonLatToCity()//去调用转换
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {//定位失败
        print(error)
        self.txtview.text = "哇靠！！定位怎么失败了呢"
    }
    
    func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation) { (placemark, error) -> Void in
            if(error == nil){
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                if let addressDic = mark.addressDictionary{
                    //这个是城市
                    if let getcity = addressDic["City"] {
                        self.city = getcity as! String
                        
//                        let end = self.city.index(self.city.endIndex, offsetBy: -1)
//                        let str2 = String(self.city.substring(to: end))
//                        self.city = str2
//
                        self.city = self .transformToPinYin(str: self.city)

                        self.loadweather()
                    }
                }
            }else{
                self.txtview.text = "定位好像失败了哦"
            }
        }
    }
    
    
    //汉字转拼音
    func transformToPinYin(str:String)->String{
        let mutableString = NSMutableString(string: str)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

