//
//  ResultsView.swift
//  Diagnostic Kit 2
//
//  Created by Kyle Murray on 1/15/17.
//  Copyright © 2017 Kyle Murray. All rights reserved.
//

import UIKit

class ResultsView: UIViewController {

    @IBOutlet weak var warning: UIImageView!
    @IBOutlet weak var range: UILabel!
    @IBOutlet weak var details: UILabel!
    var amount : Int = 20
    var receptor : String = ""
    var threshold : Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let singleton: Singleton = Singleton.getInstance
        receptor = singleton.receptor
        details.text = "Sample conatins \(amount) ppb \(receptor) antigen"
        range.text = "Acceptible range is 0-\(amount) ppb"
        if (amount <= threshold) {
            warning.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
