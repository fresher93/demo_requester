//
//  SearchController.swift
//  Calculator
//
//  Created by HoangHai on 6/15/20.
//  Copyright © 2020 HoangHai. All rights reserved.
//

import UIKit
class MyCell: UITableViewCell {
   
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var Device: UILabel!
    @IBOutlet weak var Name: UILabel!
}

class SearchController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataRequester.count
    }
  
    @IBOutlet weak var butonSerchDevice: UIButton!
    
    @IBOutlet weak var butonSeachName: UIButton!
    @IBOutlet weak var tableViewRequesters: UITableView!
    
    @IBOutlet weak var dateSeach: UIDatePicker!
    
    @IBOutlet weak var searchDivice: UITextField!
    @IBOutlet weak var searchName: UITextField!
    
    @IBOutlet weak var textName: UITextField!
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var textDivice: UITextField!
    var checkButton: Bool = true
    var checkData:Int = 0
    var searchType:String = ""
    var serachData:String = ""
    var searchUserId: Int = 0
    
    var json = [String:String]()
    var clientAPI = LoginClient()
    let requesters = [Requester]()
    var dataRequester:[[String:Any]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableViewRequesters.reloadData()
        }
    }
    func getUserId(_ data : Int)  {
        self.searchUserId = data
        print(self.searchUserId)
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyCell else { return UITableViewCell()}
        
        cell.Name.text = self.dataRequester[(indexPath.row)]["name"] as? String
        cell.Device.text = self.dataRequester[(indexPath.row)]["device"] as? String
        cell.Status.text = self.dataRequester[(indexPath.row)]["status"] as? String
        
        return cell
         
    }
    
    
    @IBAction func searchTypeClick(_ sender: UIButton) {
        if(self.checkButton == true) {
            
            butonSerchDevice.isHidden = false
            butonSeachName.isHidden = false
            self.checkButton = false
        } else {
            butonSerchDevice.isHidden = true
            butonSeachName.isHidden = true
            self.checkButton = true
        }
    }

    @IBAction func searchTypeDiviceClick(_ sender: UIButton) {
        self.checkData = 2
        
        self.searchDivice.isHidden = false
        self.searchName.isHidden = true
    }
    
    @IBAction func searchNameClick(_ sender: UIButton) {
        self.checkData = 3
         
         self.searchName.isHidden = false
         self.searchDivice.isHidden = true
    }

    @IBAction func butonSeachClick(_ sender: UIButton) {
        if self.checkData == 2 {
            self.searchType = "2"
            print(self.textDivice.text!)
            self.serachData = self.textDivice.text!
        }
        if self.checkData == 3{
            self.searchType = "3"
            self.serachData = self.textName.text!
        }
        print("user_id", self.searchUserId)
        getData(self.searchType, self.serachData, self.searchUserId)
    }
    // function get data
    func getData(_ searchType:String , _ searchData:String, _ userId : Int)  {
        let url = "http://127.0.0.1:8000/rest/api/requesters/search/"
        let httpMethod = "POST"
        let jsonData = ["user_id": userId, "search_type":searchType, "search_data": searchData] as [String : Any]
        clientAPI.Post(url, httpMethod, jsonData){
            (jsonRes) in
            self.dataRequester = jsonRes?["list_request"] as! [[String:Any]]
             DispatchQueue.main.async {
                    self.tableViewRequesters.reloadData()
                }
        }
    }
    
}



