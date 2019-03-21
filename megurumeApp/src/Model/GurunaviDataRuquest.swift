//
//  GurunaviDataRuquest.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/21.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation
import Alamofire

class GurunaviDataRuquest: NSData {
    
    let APIKey = "8a9437f47e0a95aee34dd0b89e867c8b"
    let APIUrl = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
    
    var responseData = [STBasicInfo]()
    var serchParameters = STSearchParameters()
    
    
    // シングルトンとして扱う
    private static let sharedInstance: GurunaviDataRuquest = {
        return GurunaviDataRuquest()
    }()
    // 呼び出しメソッド
    class func shared() -> GurunaviDataRuquest {
        return self.sharedInstance
    }
    
    public func request() {
        let paras: Parameters = [
            "keyid": APIKey,
            "format": "json",
            "latitude": self.serchParameters.userLocation_latitude ?? 0.0,
            "longitude": self.serchParameters.userLocation_longitude ?? 0.0,
            "range": self.serchParameters.searchRange_api ?? 1,
            "offset_page": 1,
            "hit_per_page": 50
        ]
        
        // Alamofireというライブラリを使ってapiを叩く
        Alamofire.request(APIUrl,parameters: paras).responseData{ response in
            guard let object = response.result.value else {
                return
            }
            // デコードする
            print("MARK: object is \(object)")
//            let Codabledata = try! JSONDecoder().decode(STResponceData.self, from: object)
//                print(Codabledata)
//            self.responseData.append(Codabledata.basicInfo)
//
//            self.hitResultCount = Int(Codabledata.totalHitCount)!
            
            // デコードの上、ユーザが指定した検索範囲でふるいにかける
        }
    }
}
