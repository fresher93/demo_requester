//
//  Requester.swift
//  Calculator
//
//  Created by Apple on 6/24/20.
//  Copyright © 2020 HoangHai. All rights reserved.
//

import Foundation

class Requesters: Codable {
    let requesters: [Requester]
    init(requesters:[Requester]) {
        self.requesters = requesters
    }
}

class Requester : Codable{
    let name:String
    let divice:String
    let status:String
    
    init(name: String, device: String, status:String){
        self.name = name
        self.status = status
        self.divice = device
    }
}
