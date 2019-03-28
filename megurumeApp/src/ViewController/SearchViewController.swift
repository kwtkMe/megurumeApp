//
//  ViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/20.
//  Copyright © 2019 kwtkMe. All rights reserved.
//
import UIKit
import CoreLocation

class SearchViewController: UIViewController, CLLocationManagerDelegate {
    
    // APIクライアント
    let gurunaviDataRequest = GurunaviDataRuquest.shared()
    // 位置情報マネージャ
    var locationManager: CLLocationManager!
    // よくないグローバル
    var searchRange: Int?
    var searchRange_api: Int?
    
    // MARK: UI
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var DistanceSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
        self.initLocationManager()
    }
    
    private func initSubviews() {
        // DistanceLabelを初期化
        setDistanceLabelTextAndSearchRange(distance: self.DistanceSlider.value)
        // DistanceSliderにメソッドを付与
        DistanceSlider.addTarget(self,
                                 action: #selector(didDistanceSliderChanged(sender:)),
                                 for: UIControl.Event.valueChanged)
    }
    
    private func initLocationManager() {
        // アプリケーションに「位置情報の取得に関する設定」を付与
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        // status = ユーザが位置情報を取得する許可をしたか否か
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.notDetermined) {
            self.locationManager?.requestAlwaysAuthorization()
        }
        // 精度
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        // 更新頻度(単位: m)
        locationManager?.distanceFilter = 10
        locationManager?.startUpdatingLocation()
    }
    
    @objc private func didDistanceSliderChanged(sender : UISlider) {
        setDistanceLabelTextAndSearchRange(distance: sender.value)
    }
    
    private func setDistanceLabelTextAndSearchRange(distance: Float) {
        let distance_Int = Int(distance)
        var approximateDistance: Int?
        var approximateDistance_api: Int?
        
        switch distance_Int {
        case 1:
            approximateDistance = 300
            approximateDistance_api = 1
        case 2:
            approximateDistance = 500
            approximateDistance_api = 2
        case 3:
            approximateDistance = 1000
            approximateDistance_api = 3
        case 4:
            approximateDistance = 2000
            approximateDistance_api = 4
        case 5,6:
            approximateDistance = 3000
            approximateDistance_api = 5
        default:
            approximateDistance = distance_Int
        }
        
        let insertText = "直線距離\(approximateDistance!)m圏内"
        self.DistanceLabel.text = insertText
        // serchRangeの設定
        self.searchRange = approximateDistance
        self.searchRange_api = approximateDistance_api
    }
    
    // MARK: performSegue & 検索条件の確定
    @IBAction func tapNextButton(_ sender: UIButton) {
        // 位置情報の取得
        guard let userLocation = locationManager.location?.coordinate else{
            // アラートの表示
            let alert: UIAlertController
                = UIAlertController(title: "検索エラー", message: "位置情報の取得を許可してください", preferredStyle:  UIAlertController.Style.alert)
            let defaultAction: UIAlertAction
                = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) in
            })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
            
            return
        }
        // 問題なければ検索条件を確定して画面遷移
        requestGurunaviResponse(userLocation: userLocation)
        performSegue(withIdentifier: "goResult", sender: nil)
    }
    
    private func requestGurunaviResponse(userLocation: CLLocationCoordinate2D) {
        let searchParameters = STSearchParameters(userLocation_latitude: userLocation.latitude,
                                                  userLocation_longitude: userLocation.longitude,
                                                  searchRange: self.searchRange,
                                                  searchRange_api: self.searchRange_api)
        gurunaviDataRequest.request(searchParameters: searchParameters)
    }
    
}

