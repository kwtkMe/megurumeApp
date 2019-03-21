//
//  ResponseStructs.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/21.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation
import SwiftyJSON

struct STResponceData: Codable {
    var totalHitCount : String
    var pageNum: String
    var basicInfo: [STBasicInfo]
    
    enum CodingKeys: String, CodingKey{
        case totalHitCount = "total_hit_count"
        case pageNum = "hit_per_page"
        case basicInfo
    }
}

struct STBasicInfo: Codable {
    var name: String?
    var access: STAccess?
    var address: String?
    var tel: String?
    var openTime: String?
    var pr: STProfile?
    var imageURL: STImageURL?
    var urlMobile: String?
    
    enum CodingKeys: String, CodingKey{
        case name
        case access
        case address
        case tel
        case openTime = "opentime"
        case pr
        case imageURL = "image_url"
        case urlMobile = "url_mobile"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decode(String.self ,forKey: .name)
        access = try? values.decode(STAccess.self ,forKey: .access)
        address = try? values.decode(String.self ,forKey: .address)
        tel = try? values.decode(String.self ,forKey: .tel)
        openTime = try? values.decode(String.self ,forKey: .openTime)
        pr = try? values.decode(STProfile.self ,forKey: .pr)
        imageURL = try? values.decode(STImageURL.self ,forKey: .imageURL)
        urlMobile = try? values.decode(String.self ,forKey: .urlMobile)
    }
}

struct STAccess: Codable {
    var station : String?
    var exit : String?
    var walk : String?
    
    enum CodingKeys: String, CodingKey {
        case station
        case exit = "station_exit"
        case walk
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        station = try? values.decode(String.self ,forKey: .station)
        exit = try? values.decode(String.self ,forKey: .exit)
        walk = try? values.decode(String.self ,forKey: .walk)
    }
}

struct STImageURL:Codable {
    var shopImage : String?
    
    enum CodingKeys: String, CodingKey{
        case shopImage = "shop_image1"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.shopImage = try? values.decode(String.self ,forKey: .shopImage)
    }
}

struct STProfile: Codable {
    let prShort: String?
    let prLong: String?
    
    enum CodingKeys: String, CodingKey {
        case prShort = "pr_short"
        case prLong = "pr_long"
    }
}

