//
//  roads.swift
//  classproject
//
//  Created by rchapell on 11/19/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import Foundation
class roads{
    var roads:[road] = []
    init(){
    }
    func addroad(newroad: road){
        roads.append(newroad)
    }
    func deleteall(){
        roads.removeAll()
    }
}
class road{
    var name:String?
    init(nm: String){
       name = nm
    }
}
