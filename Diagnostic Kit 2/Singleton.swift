//
//  Singelton.swift
//  Camera Fun
//
//  Created by Kyle Murray on 1/5/17.
//  Copyright © 2016 Kyle Murray. All rights reserved.
//

import Foundation

class Singleton {
    var receptor : String = ""
    var result : Int = 0
    
    //    fileprivate static var instance : Singleton? = nil
    //
    //    static func getInstance() -> Singleton {
    //        if instance == nil {
    //            instance = Singleton()
    //        }
    //        return instance!
    //    }
    //
    //    fileprivate init() {
    //
    //    }
    
    static let getInstance : Singleton = {
        let instance = Singleton()
        return instance
    }()
    
    init() { 
        
    }
}
