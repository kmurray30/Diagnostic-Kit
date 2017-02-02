//
//  ViewController.swift
//  MP3Player
//
//  Created by James Tyner on 7/5/15.
//  Copyright (c) 2015 James Tyner. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var mp3Player:MP3Player?
    var timer:Timer?
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackTime: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mp3Player = MP3Player()
    }
    func updateViewsWithTimer(_ timer: Timer){
        mp3Player?.stop()
    }
    @IBAction func playSong(_ sender: AnyObject) {
        mp3Player?.play()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateViewsWithTimer(_:)), userInfo: nil, repeats: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
