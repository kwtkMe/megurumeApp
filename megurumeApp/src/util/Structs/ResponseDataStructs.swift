//
//  ResponseStructs.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/21.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

struct STResponceData: Codable {
    var totalHitCount: Int?
    var pageNum: Int?
    var basicInfo: [STBasicInfo]?
    
    enum CodingKeys: String, CodingKey{
        case totalHitCount = "total_hit_count"
        case pageNum = "hit_per_page"
        case basicInfo = "rest"
    }
    
    init(from decoder: Decoder) throws {
        let values    = try decoder.container(keyedBy: CodingKeys.self)
        totalHitCount = try? values.decode(Int.self ,forKey: .totalHitCount)
        pageNum       = try? values.decode(Int.self ,forKey: .pageNum)
        basicInfo     = try? values.decode([STBasicInfo].self ,forKey: .basicInfo)
    }
}

struct STBasicInfo: Codable {
    var name: String?
    var telNumber: String?
    var address: String?
    var openTime: String?
    var holiday: String?
    var budget: Int?
    var creditCard: String?
    var latitude: String?
    var longitude: String?
    var tumbnail: STTumbNail?
    var access: STAccess?
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case telNumber = "tel"
        case address = "address"
        case openTime = "opentime"
        case holiday = "holiday"
        case budget = "budget"
        case creditCard = "credit_card"
        case latitude = "latitude"
        case longitude = "longitude"
        case tumbnail = "image_url"
        case access = "access"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name       = try? values.decode(String.self ,forKey: .name)
        telNumber  = try? values.decode(String.self ,forKey: .telNumber)
        address    = try? values.decode(String.self ,forKey: .address)
        openTime   = try? values.decode(String.self ,forKey: .openTime)
        holiday    = try? values.decode(String.self ,forKey: .holiday)
        budget     = try? values.decode(Int.self ,forKey: .budget)
        creditCard = try? values.decode(String.self ,forKey: .creditCard)
        latitude   = try? values.decode(String.self ,forKey: .latitude)
        longitude  = try? values.decode(String.self ,forKey: .longitude)
        tumbnail   = try? values.decode(STTumbNail.self, forKey: .tumbnail)
        access     = try? values.decode(STAccess.self, forKey: .access)
    }
}

struct STTumbNail: Codable {
    var imageURL1: String?
    var imageURL2: String?
    
    enum CodingKeys: String, CodingKey{
        case imageURL1 = "shop_image1"
        case imageURL2 = "shop_image2"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL1 = try? values.decode(String.self ,forKey: .imageURL1)
        self.imageURL2 = try? values.decode(String.self ,forKey: .imageURL2)
    }
}

struct STAccess: Codable {
    var stationLine: String?
    var stationName: String?
    var stationExit: String?
    var walkTime: String?
    
    enum CodingKeys: String, CodingKey {
        case stationLine = "line"
        case stationName = "station"
        case stationExit = "station_exit"
        case walkTime = "walk"
    }
    
    init(from decoder: Decoder) throws {
        let values   = try decoder.container(keyedBy: CodingKeys.self)
        stationLine  = try? values.decode(String.self, forKey: .stationLine)
        stationName  = try? values.decode(String.self, forKey: .stationName)
        stationExit  = try? values.decode(String.self, forKey: .stationExit)
        walkTime     = try? values.decode(String.self, forKey: .walkTime)
    }
}
