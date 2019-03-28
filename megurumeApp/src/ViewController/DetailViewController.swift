//
//  DetailViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/20.
//  Copyright © 2019 kwtkMe. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController {
    
    // APIクライアント
    let gurunaviDataRequest = GurunaviDataRuquest.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func tapGoogleMapbutton(_ sender: UIBarButtonItem) {
        // 画面遷移
        let nextvc = GoogleMapsViewController()
        self.present(nextvc, animated: true, completion: nil)
    }
    @IBAction func tapTelButton(_ sender: UIButton) {
        let selectedCellIndex = gurunaviDataRequest.selectedCellIndex
        if let telNumber = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex!].telNumber {
            switch telNumber {
            case "":
                showAlert()
            default:
                UIApplication.shared.open(URL(string: "telprompt://\(telNumber)")!, completionHandler:nil)
            }
        } else {
            showAlert()
        }
    }
    
    private func showAlert() {
        let alert: UIAlertController
            = UIAlertController(title: "エラー", message: "電話番号のデータがありません", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction
            = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) in
            })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}
