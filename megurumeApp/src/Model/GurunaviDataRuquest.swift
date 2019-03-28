//
//  GurunaviDataRuquest.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/21.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import CoreLocation
import Alamofire


class GurunaviDataRuquest {
    
    let APIKey = "8a9437f47e0a95aee34dd0b89e867c8b"
    let APIUrl = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
    // 取得データ
    var responseData: STResponceData?
    // うーん
    var selectedCellIndex: Int?
    
    // シングルトンとして扱う
    private static let sharedInstance: GurunaviDataRuquest = {
        return GurunaviDataRuquest()
    }()
    // 呼び出しメソッド
    class func shared() -> GurunaviDataRuquest {
        return self.sharedInstance
    }
    
    public func request(searchParameters: STSearchParameters) {
        let paras: Parameters = [
            "keyid": APIKey,
            "hit_per_page": 100, // 最大100件ヒットするものする
            "latitude": searchParameters.userLocation_latitude ?? 0.0,
            "longitude": searchParameters.userLocation_longitude ?? 0.0,
            "range": searchParameters.searchRange_api ?? 1
        ]
        
        // HTTPの通信待機
        var keepAlive = true
        
        // Alamofireというライブラリを使ってapiを叩く
        Alamofire.request(APIUrl, parameters: paras)
            .responseJSON{ response in
                guard let object = response.data else {
                    return
                }
                // デコードする
                self.responseData = try! JSONDecoder().decode(STResponceData.self, from: object)
                
                keepAlive = false
        }
        
        let runLoop = RunLoop.current
        while keepAlive && runLoop.run(mode: RunLoop.Mode.default, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
        }
    }
}
