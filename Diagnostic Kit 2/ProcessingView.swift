//
//  ProcessingView.swift
//  Diagnostic Kit 2
//
//  Created by Kyle Murray on 1/15/17.
//  Copyright © 2017 Kyle Murray. All rights reserved.
//

import UIKit
import AVFoundation

class ProcessingView: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var viewResults: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // MP3 output vars
    var mp3Player:MP3Player?
    var timer:Timer?
    
    // Mic input vars
    var recordingSession: AVAudioSession!
    let engine = AVAudioEngine()
    let sampleCount = 100;
    let singleton: Singleton = Singleton.getInstance
    
     var threadTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Audio output
        viewResults.isHidden = true
        progressBar.progress = 0
        // Reset results data
        singleton.results = [Float](repeating: 0, count:100)
        singleton.currentIndex = 0
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        mp3Player = MP3Player()
        mp3Player?.play()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.updateViewsWithTimer(_:)), userInfo: nil, repeats: false)
        
        // ask user for permission to record. Move to home screen when connected if possible
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        // Should probably set a boolean flag. for now we assume permission was given
                    }
                }
            }
        } catch {
            // TODO add error message
        }
        
        self.getSamples()
        for i in 0 ... self.sampleCount-1{
            print(singleton.results[i])  // CURRENTLY I'M JUST PRINTING THE RESULTS. this should be 24 numbers printed to console
        }
        
        // viewResults.isHidden = false
        
    }
    
    // For Nick's code (audio output)
    func updateViewsWithTimer(_ timer: Timer){
        engine.stop()
        mp3Player?.stop()
    }
    
    // For Sidney's code (mic input)
    func getSamples() {
        let input = engine.inputNode!
        let bus = 0
        
        // 16537/44100 = .375 seconds
        // modify buffer.frameLength: http://stackoverflow.com/questions/26115626/i-want-to-call-20-times-per-second-the-installtaponbusbuffersizeformatblock
        
        input.installTap(onBus: bus, bufferSize: 512, format: input.inputFormat(forBus: bus)) { (buffer, time) -> Void in
            buffer.frameLength = 4410
            
            let samples = buffer.floatChannelData?[0]
            //print(buffer.frameLength)
            //print(samples?[16536])
            var sum : Float = 0.0
            
            var lastSamplePositive : Bool = true
            
            for i in 0 ... buffer.frameLength-1{
                // if sign just switched
                if( lastSamplePositive != (samples![Int(i)] > Float(0.0)) ){
                    lastSamplePositive = !lastSamplePositive
                    sum += 1
                }
            }
            //print(sum)
            //print("")
            
            print(sum)
            
            //print(self.currentIndex)
            
            if (self.singleton.currentIndex < 100) {
                self.singleton.results[self.singleton.currentIndex] = sum
                self.singleton.currentIndex += 1
            }
        }
        
        try! engine.start()
        //sleep(UInt32(Int(0.1*Double(sampleCount))))
        
        threadTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        print("about to stop engine")
        print("engine stopped")
        self.singleton.currentIndex = 0

    }
    
    @IBAction func pressedFinish(_ sender: AnyObject) {
        viewResults.isHidden = false
        progressBar.progress = 1
    }
    
    @IBAction func pressedPass(_ sender: AnyObject) {
        //self.singleton.result = 3
    }
    
    @IBAction func pressedFail(_ sender: AnyObject) {
        //self.singleton.result = 20
    }

    @IBAction func pressedCancel(_ sender: Any) {
        engine.stop()
        mp3Player?.stop()
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
