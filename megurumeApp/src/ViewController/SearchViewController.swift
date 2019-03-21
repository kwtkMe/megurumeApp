//
//  ViewController.swift
//  megurumeApp
//
//  Created by RIVER on 2019/03/20.
//  Copyright © 2019 kwtkMe. All rights reserved.
//
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var DistanceSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DistanceLabel.text = "\(DistanceSlider.value)"
        DistanceSlider.addTarget(self,
                                 action: #selector(didDistanceSliderChanged(sender:)),
                                 for: UIControl.Event.valueChanged)
    }
    
    @objc private func didDistanceSliderChanged(sender : UISlider) {
        DistanceLabel.text = "\(sender.value)"
    }
    
    //MARK: performSegue
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goResult", sender: nil)
    }
    
}

