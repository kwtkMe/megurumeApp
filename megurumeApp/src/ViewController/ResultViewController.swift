//
//  ResultViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/20.
//  Copyright © 2019 kwtkMe. All rights reserved.
//
import UIKit
import Alamofire
import AlamofireImage

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // APIクライアント
    let gurunaviDataRequest = GurunaviDataRuquest.shared()
    // 選択されたcellの位置
    var selectedCellIndex: Int?
    
    // MARK: UI
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("RESULT")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellNum = 0
        let pageNum: Int = gurunaviDataRequest.responseData?.pageNum ?? 0
        let totalHitCount: Int = gurunaviDataRequest.responseData?.totalHitCount ?? 0
        // ヒット件数によって返すセルの数をハンドリングする
        // ページング処理しない
        if pageNum < totalHitCount {
            cellNum = pageNum
        } else {
            cellNum = totalHitCount
        }
        
        return cellNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = setTableViewCellProperty(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gurunaviDataRequest.selectedCellIndex = indexPath.row
        // 画面遷移
        performSegue(withIdentifier: "goDetail", sender: nil)
    }
    
    func setTableViewCellProperty(indexPath: IndexPath) -> UITableViewCell {
        // カスタムセルのためのプロパティを整形
        let gurumeName = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].name ?? "不明な店名"
        let accessLine = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].access?.stationLine ?? ""
        let accessName = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].access?.stationName ?? ""
        let accessExit = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].access?.stationExit ?? ""
        let accessWalkTime = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].access?.walkTime ?? ""
        let gurumeAccess = accessLine + accessName + accessExit + "から" + accessWalkTime + "分"
    
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ResultTableViewCell
        
        cell.gurumeNameLabel.text = "\(indexPath.row + 1) : " + gurumeName
        cell.gurumeAccessLabel.text = gurumeAccess
        // サムネイルの設定
        let defaultImage = UIImage(named: "defaultImage")
        cell.gurumeThumbnailImageView.image = defaultImage
        if let imageURL = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].tumbnail?.image1 {
            if imageURL != "" {
                Alamofire.request(imageURL).responseImage { response in
                    cell.gurumeThumbnailImageView.image = response.value
                }
            }else {
                cell.gurumeThumbnailImageView.backgroundColor = .gray
            }
        }else {
            cell.gurumeThumbnailImageView.backgroundColor = .red
        }
        
        return cell
    }
}
