//
//  GoogleMapsViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapsViewController: UIViewController {
    
    // APIクライアント
    let gurunaviDataRequest = GurunaviDataRuquest.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initSubViews()
    }
    
    private func initSubViews() {
        let selectedCellIndex = gurunaviDataRequest.selectedCellIndex!
        var gurumeLatitude: Double?
        var gurumeLongitude: Double?
        
        if let insertText = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex].latitude {
            switch insertText {
            case "":
                gurumeLatitude = 0.0
            default:
                gurumeLatitude = Double(insertText)
            }
        } else {
            gurumeLatitude = 0.0
        }
        if let insertText = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex].longitude {
            switch insertText {
            case "":
                gurumeLongitude = 0.0
            default:
                gurumeLongitude = Double(insertText)
            }
        } else {
            gurumeLongitude = 0.0
        }

        // マップの見た目を設定
        let camera = GMSCameraPosition.camera(withLatitude: gurumeLatitude!, longitude: gurumeLongitude!, zoom: 18.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        // 店の位置にピンを打つ
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: gurumeLatitude!, longitude: gurumeLongitude!)
        marker.title = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex].name ?? "不明な店名"
        marker.map = mapView
        
        self.view = mapView
    }
}
