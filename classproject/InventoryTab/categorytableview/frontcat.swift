//
//  frontcat.swift
//  classproject
//
//  Created by rchapell on 10/31/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit
class frontcat{
    var frontcat:[fcategoryfolder] = []
    init(){
        let c1 = fcategoryfolder(fn: "Bobas")
        let c2 = fcategoryfolder(fn: "Coffee")
        let c3 = fcategoryfolder(fn: "Dairy")
        let c4 = fcategoryfolder(fn: "Fruits")
        let c5 = fcategoryfolder(fn: "Monin")
        let c6 = fcategoryfolder(fn: "Syrups")
        let c7 = fcategoryfolder(fn: "Tea")
        let c8 = fcategoryfolder(fn: "Powders")
        let c9 = fcategoryfolder(fn: "Misc")
        
        frontcat.append(c1)
        frontcat.append(c2)
        frontcat.append(c3)
        frontcat.append(c4)
        frontcat.append(c5)
        frontcat.append(c6)
        frontcat.append(c7)
        frontcat.append(c8)
        frontcat.append(c9)
    }
}
class fcategoryfolder{
    var catName:String?
    init(fn: String){
        catName = fn
     
    }
}
