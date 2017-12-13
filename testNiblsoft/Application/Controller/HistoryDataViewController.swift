//
//  HistoryDataViewController.swift
//  testNiblsoft
//
//  Created by Руслан on 13.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import UIKit

class HistoryDataViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temprLabel: UILabel!
    
    var cityStr: String = ""
    var latitudeStr: String = ""
    var longitudeStr: String = ""
    var dateStr: String = ""
    var temprStr: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = cityStr
        latitudeLabel.text = latitudeStr
        longitudeLabel.text = longitudeStr
        dateLabel.text = dateStr
        temprLabel.text = temprStr + "°"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
