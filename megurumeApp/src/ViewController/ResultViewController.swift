//
//  ResultViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/20.
//  Copyright © 2019 kwtkMe. All rights reserved.
//
import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // APIクライアント
    let gurunaviDataRequest = GurunaviDataRuquest.shared()
    
    // MARK: UI
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubViews()
    }
    
    // return cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gurunaviDataRequest.responseData?.pageNum ?? 0
    }
    
    // instance cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! CustomTableViewCell

        // 取得件数の限界を検知する必要がある(?)
        let pageNum = gurunaviDataRequest.responseData?.pageNum
        if pageNum != indexPath.row {
            cell.gurumeNameLabel.text
                = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].name
            cell.gurumeTumbnailImageView.image
                =
            cell.gurumeAccessLabel.text
                = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].name
            cell.gurumeBudgetLabel.text
                = gurunaviDataRequest.responseData?.basicInfo?[indexPath.row].name
        } else {
            cell.textLabel?.text = "this is limit"
        }
        
        return cell
    }
    
    private func initSubViews() {
        
    }
    
}
