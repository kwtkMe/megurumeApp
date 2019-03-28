//
//  DetailContentViewControllerTableViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailContentViewControllerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gurumeThumbnailImageView: UIImageView!
    @IBOutlet weak var gurumeNameLabel: UILabel!
    @IBOutlet weak var gurumeAccessLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // APIクライアント
    let gurunaviDataRequest = GurunaviDataRuquest.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "detailCell")
        initSubViews()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        let selectedCellIndex = gurunaviDataRequest.selectedCellIndex
        switch indexPath.row {
        case 0:
            cell.cellTitleLabel.text = "電話番号"
            if let insertText = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex!].telNumber {
                switch insertText {
                case "":
                    cell.cellContentLabel.text = "データなし"
                default:
                    cell.cellContentLabel.text = insertText
                }
            } else {
                cell.cellContentLabel.text = "データなし"
            }
        case 1:
            cell.cellTitleLabel.text = "住所"
            if let insertText = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex!].address {
                switch insertText {
                case "":
                    cell.cellContentLabel.text = "データなし"
                default:
                    cell.cellContentLabel.text = insertText
                }
            } else {
                cell.cellContentLabel.text = "データなし"
            }
        case 2:
            cell.cellTitleLabel.text = "営業時間"
            if let insertText = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex!].openTime {
                switch insertText {
                case "":
                    cell.cellContentLabel.text = "データなし"
                default:
                    cell.cellContentLabel.text = insertText
                }
            } else {
                cell.cellContentLabel.text = "データなし"
            }
        case 3:
            cell.cellTitleLabel.text = "定休日"
            if let insertText = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex!].holiday {
                switch insertText {
                case "":
                    cell.cellContentLabel.text = "データなし"
                default:
                    cell.cellContentLabel.text = insertText
                }
            } else {
                cell.cellContentLabel.text = "データなし"
            }
        case 4:
            cell.cellTitleLabel.text = "予算"
            if let insertText = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex!].budget {
                cell.cellContentLabel.text = String(insertText) + "円"
            } else {
                cell.cellContentLabel.text = "データなし"
            }
        case 5:
            cell.cellTitleLabel.text = "クレジットカード"
            if let insertText = gurunaviDataRequest.responseData?.basicInfo?[selectedCellIndex!].creditCard {
                switch insertText {
                case "":
                    cell.cellContentLabel.text = "データなし"
                default:
                    cell.cellContentLabel.text = insertText
                }
            } else {
                cell.cellContentLabel.text = "データなし"
            }
        default:
            break
        }
        
        return cell
    }
    
    private func initSubViews() {
        // カスタムセルのためのプロパティを整形
        let gurumeName = gurunaviDataRequest.responseData?.basicInfo?[gurunaviDataRequest.selectedCellIndex!].name ?? "不明な店名"
        let accessLine = gurunaviDataRequest.responseData?.basicInfo?[gurunaviDataRequest.selectedCellIndex!].access?.stationLine ?? ""
        let accessName = gurunaviDataRequest.responseData?.basicInfo?[gurunaviDataRequest.selectedCellIndex!].access?.stationName ?? ""
        let accessExit = gurunaviDataRequest.responseData?.basicInfo?[gurunaviDataRequest.selectedCellIndex!].access?.stationExit ?? ""
        let accessWalkTime = gurunaviDataRequest.responseData?.basicInfo?[gurunaviDataRequest.selectedCellIndex!].access?.walkTime ?? ""
        let gurumeAccess = accessLine + accessName + accessExit + "から" + accessWalkTime + "分"
        
        self.gurumeNameLabel.text = gurumeName
        self.gurumeAccessLabel.text = gurumeAccess
        if let thumbnailURL = gurunaviDataRequest.responseData?.basicInfo?[gurunaviDataRequest.selectedCellIndex!].tumbnail?.imageURL1 {
            if thumbnailURL == "" {
                self.gurumeThumbnailImageView.backgroundColor = .lightGray
            } else {
                self.gurumeThumbnailImageView.af_setImage(withURL: URL(string: thumbnailURL)!)
            }
        }
    }
    

}
