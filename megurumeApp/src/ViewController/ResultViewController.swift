//
//  ResultViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/20.
//  Copyright © 2019 kwtkMe. All rights reserved.
//
import UIKit

class ResultViewController: UIViewController {
    
    let gurunaviDataRequest = GurunaviDataRuquest.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gurunaviDataRequest.request()
    }
    
    
}
