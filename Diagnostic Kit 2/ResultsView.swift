//
//  ResultsView.swift
//  Diagnostic Kit 2
//
//  Created by Kyle Murray on 1/15/17.
//  Copyright © 2017 Kyle Murray. All rights reserved.
//

import UIKit

class ResultsView: UIViewController {

    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var warning: UIImageView!
    @IBOutlet weak var range: UILabel!
    @IBOutlet weak var details: UILabel!
    var amount : Int = 0
    var receptor : String = ""
    var threshold : Float = 1000
    let singleton: Singleton = Singleton.getInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let frac = 6
        let start = singleton.results.count * 1/frac
        let end = singleton.results.count * (frac-1)/frac
        
        var total: Float = 0
        for i in start...end {
            total += singleton.results[i]
        }
        let result = total/Float(end-start+1)
        
        receptor = singleton.receptor
        details.text = "Sample conatins \(result) ppb \(receptor) antigen"
        range.text = "Acceptible range is 0-\(threshold) ppb"
        if (result <= threshold) {
            warning.isHidden = true
        } else {
            heart.isHidden = true
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
