//
//  folders.swift
//  classproject
//
//  Created by rchapell on 10/31/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit
class folders{
    var folders:[folder] = []
    init(){
       
        let f1 = folder(fn: "Front Store")
        let f2 = folder(fn: "Back Store")
        folders.append(f1)
        folders.append(f2)
    }
}
class folder{
    var folderName:String?
    var attention:UIImage?
    init(fn: String){
        folderName = fn
 
    }
}
