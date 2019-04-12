//
//  ExchangeType.swift
//  megurumeApp
//
//  Created by RIVER on 2019/04/01.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit


extension UIImage {
    
    func toBase64EncodedStringString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

extension String {
    
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
