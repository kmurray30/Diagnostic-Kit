//
//  ProcessingView.swift
//  Diagnostic Kit 2
//
//  Created by Kyle Murray on 1/15/17.
//  Copyright © 2017 Kyle Murray. All rights reserved.
//

import UIKit

class ProcessingView: UIViewController {
    
    @IBOutlet weak var viewResults: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    var gameTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewResults.isHidden = true
        progressBar.progress = 0
        gameTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    func runTimedCode() {
        if (progressBar.progress < 0.99) {
            progressBar.progress = progressBar.progress + 0.01;
        } else {
            viewResults.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedFinish(_ sender: AnyObject) {
        viewResults.isHidden = false
        progressBar.progress = 1
    }
    
    @IBAction func pressedPass(_ sender: AnyObject) {
        let singleton: Singleton = Singleton.getInstance
        singleton.result = 3
    }
    
    @IBAction func pressedFail(_ sender: AnyObject) {
        let singleton: Singleton = Singleton.getInstance
        singleton.result = 20
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
