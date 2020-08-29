//
//  AppDataManager.swift
//  Chatty
//
//  Created by typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import Foundation


class AppDataManager {
    
    static let shared = AppDataManager()

    private init() {
        
    }
    
    var userId : String? {
        get {
           return UserDefaults.standard.string(forKey: "user_id")
        } set (value) {
            UserDefaults.standard.set(value, forKey: "user_id")
            UserDefaults.standard.synchronize()
        }
    }
    
}
