//
//  LoginClient.swift
//  Calculator
//
//  Created by Bui Cong Dai on 6/17/20.
//  Copyright © 2020 HoangHai. All rights reserved.
//

import Foundation
struct APIResponse : Decodable{
    var code : Int
    var messager:String
    var status_code: String
}

class LoginClient{
    var requestesNew = [Requester]()
    var json = [String:String]()
    typealias JSONDictionaryHandler = (([String:Any]?)->Void)
    func postJson(_ username:String, _ password:String , comletion: @escaping ([String:Any]?)->()){

        print("LoginClient -> postJson()")
        let url = URL(string: "http://127.0.0.1:8000/rest/api/authen/requester/login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.json["username"] = username
        self.json["password"] = password
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: self.json, options: []) {
            URLSession.shared.uploadTask(with: request, from: jsonData, completionHandler: { (data, response, error) in
                if let data = data {
                    
                    DispatchQueue.main.async { // Correct
                           do{
                        let json:Any?
                        json = try JSONSerialization.jsonObject(with: data, options: [])
                        let jsonDic = json as! [String:Any]
                        comletion(jsonDic)
                    }catch{
                    return
                }
             }
            }
            }).resume()
        }
    }
      
    // test input api
    func Post(_ url:String, _ httpMethod:String, _ jsonBody:[String:Any] , completion: @escaping ([String:Any]?)->()){
        let url = URL(string: url)
        var request = URLRequest(url:url!)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let  jsonData = try? JSONSerialization.data(withJSONObject: jsonBody, options: [])
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            if let data = data, error == nil, response != nil{
                DispatchQueue.main.async {
                    do{
                    let dataRes = try JSONSerialization.jsonObject(with: data , options: []) as! [String:Any]
                    print(dataRes)
                    completion(dataRes)
                    }catch{
                        return
                    }
                }
            }
            }).resume()
    }
    
    
      func postRegist(_ username:String, _ password:String , comletion: @escaping ([String:Any]?)->()){

          print("LoginClient -> postRegist()")
          let url = URL(string: "http://127.0.0.1:8000/rest/api/regist/requesters")
          var request = URLRequest(url: url!)
          request.httpMethod = "POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          self.json["username"] = username
          self.json["password"] = password
          
          if let jsonData = try? JSONSerialization.data(withJSONObject: self.json, options: []) {
              URLSession.shared.uploadTask(with: request, from: jsonData, completionHandler: { (data, response, error) in
                  if let data = data {
                      
                      DispatchQueue.main.async { // Correct
                             do{
                          let json:Any?
                          json = try JSONSerialization.jsonObject(with: data, options: [])
                          let jsonDic = json as! [String:Any]
                          comletion(jsonDic)
                      }catch{
                      return
                  }
               }
              }
              }).resume()
          }
      }
    

    func getJson(_ user_id:String, _ serch_type:String , _ search_data:String, completion: @escaping ([String: Any])->()){
        let url = URL(string: "http://127.0.0.1:8000/rest/api/requesters/search/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.json["user_id"] = user_id
        self.json["search_type"] = serch_type
        self.json["search_data"] = search_data
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []){
            let session = URLSession.shared
            let task = session.uploadTask(with: request, from: jsonData,
            completionHandler: {data, response, error in
                if error != nil{
                    return
                }
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]{
                    if let list_request =  json["list_request"] as? [String:Any]{
                        print(list_request)
                         completion(list_request)
                    }
                }
            })
            task.resume()
        }
    }
}
