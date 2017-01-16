//
//  ViewController.swift
//  Diagnostic Kit
//
//  Created by Kyle Murray on 1/15/17.
//  Copyright © 2017 Kyle Murray. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var testSelected = false;
    var deviceConnected = false;
    
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var connectDeviceLabel: UILabel!
    @IBOutlet weak var selection1: UIView!
    @IBOutlet weak var selection2: UIView!
    let items : [String] = [" ", "NOD1", "NOD2", "RIG-I"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        proceedBtn.isHidden = true
        selection1.isHidden = true
        selection2.isHidden = true
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row > 0 {
            selectionLabel.text = "You have selected \(items[row])"
            testSelected = true
            selection1.isHidden = false
        } else {
            selectionLabel.text = "Select test"
            testSelected = false
            selection1.isHidden = true
        }
        if (deviceConnected && testSelected) {
            proceedBtn.isHidden = false;
        } else {
            proceedBtn.isHidden = true;
        }
        let singleton: Singleton = Singleton.getInstance
        singleton.receptor = items[row]
    }
    
    @IBAction func ConnectDevice(_ sender: AnyObject) {
        connectDeviceLabel.text = "Device connected"
        deviceConnected = true
        selection2.isHidden = false
        if (deviceConnected && testSelected) {
            proceedBtn.isHidden = false;
        } else {
            proceedBtn.isHidden = true;
        }
    }
    
    @IBAction func DisconnectDevice(_ sender: AnyObject) {
        connectDeviceLabel.text = "Connect device"
        deviceConnected = false;
        selection2.isHidden = true
        if (deviceConnected && testSelected) {
            proceedBtn.isHidden = false;
        } else {
            proceedBtn.isHidden = true;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

