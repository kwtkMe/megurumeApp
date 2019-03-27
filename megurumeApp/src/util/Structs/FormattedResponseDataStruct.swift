//
//  FormattedResponseDataStruct.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit

struct STFormattedResponceData{
    var totalHitCount: String?
    var pageNum: String?
    var basicInfo: [STBasicInfo]?
}

struct STFormattedBasicInfo{
    var name: String?
    var telNumber: String?
    var address: String?
    var openTime: String?
    var holiday: String?
    var budget: String?
    var creditCard: String?
    var tumbnail: STFormattedTumbNail?
    var access: STFormattedAccess?
}

struct STFormattedTumbNail{
    var image1: UIImage?
    var image2: UIImage?
}

struct STFormattedAccess{
    var stationLine: String?
    var stationName: String?
    var stationExit: String?
    var walkTime: String?
}
