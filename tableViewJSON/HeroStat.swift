//
//  HeroStat.swift
//  tableViewJSON
//
//  Created by macOS on 4/24/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import MagicMapper

@objcMembers
class Hero: NSObject, Mappable {
     
    
    
    

    
    var localized_name:String = ""
    var primary_attr:String = ""
    var attack_type:String = ""
    var legs:Int = 1
    var img:String = ""
   
//    init(localized_name:String,primary_attr:String,attack_type:String,legs:Int,img:String) {
//        self.localized_name = localized_name
//        self.primary_attr = primary_attr
//        self.attack_type = attack_type
//        self.legs = legs
//        self.img = img
//
//    }
   
    
}

