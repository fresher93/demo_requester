//
//  ViewModels.swift
//  Calculator
//
//  Created by Apple on 6/23/20.
//  Copyright © 2020 HoangHai. All rights reserved.
//

import Foundation
class ViewModel{
    var loginClient: LoginClient!
    var requester: [String:Any]?
    func fetchData(_ userId:String, _ searchType:String , _ searchData:String) {
        loginClient.getJson(userId, searchType, searchData){
            requester in self.requester = requester
        }
    }
    func numbarOfItemSecsion(sesion: Int) -> Int {
        return requester?.count ?? 0
    }
    
  
}
