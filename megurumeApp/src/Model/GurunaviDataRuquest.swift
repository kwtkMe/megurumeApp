//
//  GurunaviDataRuquest.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/21.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation
import Alamofire


class GurunaviDataRuquest {
    
    let APIKey = "8a9437f47e0a95aee34dd0b89e867c8b"
    let APIUrl = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
    // 取得データ
    var responseData: STResponceData?
    // 整形済みデータ
    var formattedReaponseData: STFormattedResponceData?
    
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
            "hit_per_page": 5, // 最大30件ヒットするものする
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
                // デコードの上、ユーザが指定した検索範囲でふるいにかける
        }
        let runLoop = RunLoop.current
        while keepAlive && runLoop.run(mode: RunLoop.Mode.default, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
                // 0.1秒毎の処理なので、処理が止まらない
        }
    }
    
    private func formatResponceData() {
        guard let responceData = self.responseData else {
            return
        }
        
        self.formattedReaponseData?.totalHitCount = String(responceData.totalHitCount!)
        self.formattedReaponseData?.pageNum = String(responceData.pageNum!)
        for basicInfo in responceData.basicInfo! {
            var formattedBasicInfo: STFormattedBasicInfo?
            formattedBasicInfo?.name = basicInfo.name
            formattedBasicInfo?.telNumber = basicInfo.telNumber
            formattedBasicInfo?.address = basicInfo.address
            formattedBasicInfo?.openTime = basicInfo.openTime
            formattedBasicInfo?.holiday = basicInfo.holiday
            formattedBasicInfo?.creditCard = basicInfo.creditCard
            // URLから画像を取得
            if let url1 = basicInfo.tumbnail?.imageURL1 {
                Alamofire.request(url1).responseData{ response in
                    if let image = response.result.value {
                        formattedBasicInfo?.tumbnail?.image1 = image as UIImage
                    }
                }
            }
            if let url1 = basicInfo.tumbnail?.imageURL1 {
                
            }
            
            var name: String?
            var telNumber: String?
            var address: String?
            var openTime: String?
            var holiday: String?
            var budget: String?
            var creditCard: String?
            var tumbnail: STFormattedTumbNail?
            var access: STFormattedAccess?
            
            self.formattedReaponseData?.basicInfo?.append(formattedBasicInfo)
        }
    }
}
