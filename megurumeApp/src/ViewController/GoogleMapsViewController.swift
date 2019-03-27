//
//  GoogleMapsViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit

class GoogleMapsViewController: UIViewController {
    
    // NotificationCenter
    let notification = NotificationCenter.default
    deinit { notification.removeObserver(self) }
    
    // MARK: NotificationCenterに関する記述
    private func initObservers() {
        notification.addObserver(self,
                                 selector: #selector(handleDidFetchedRequestNotification(_:)),
                                 name: .DidFetchedRequest, object: nil)
    }
    
    @objc func handleDidFetchedRequestNotification(_ notification: Notification) {
        // self.tableView.reloadData()
    }
}
