//
//  backcat.swift
//  classproject
//
//  Created by rchapell on 11/5/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import Foundation
import UIKit
class backcat {
    var backcat:[bcategoryfolder] = []
    init(){
        let c1 = bcategoryfolder(fn: "Bathroom")
        let c2 = bcategoryfolder(fn: "Cleaning")
        let c3 = bcategoryfolder(fn: "Cups")  
        backcat.append(c1)
        backcat.append(c2)
        backcat.append(c3)
    }
}
class bcategoryfolder{
    var catName:String?
    init(fn: String){
        catName = fn
        
    }
}
