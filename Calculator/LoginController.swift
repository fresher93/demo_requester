//
//  LoginController.swift
//  Calculator
//
//  Created by Bui Cong Dai on 6/18/20.
//  Copyright © 2020 HoangHai. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    var url = "http://127.0.0.1:8000/rest/api/authen/requester/login"
    var httpMethod = "POST"
    @IBOutlet weak var username: UITextField!
    var loginClient = LoginClient()
    var loginString = ""
    var userId = 0
    var searchController = SearchController()
    @IBOutlet weak var pasword: UITextField!
    var requesters:[NSDictionary] = []
    @IBOutlet weak var login: UIButton!
    @IBAction func login(_ sender: UIButton) {
        let jsonInput = ["username": String(username.text!), "password":String(pasword.text!)]
        if(sender.tag == 1) {
            loginClient.Post(url,httpMethod,jsonInput){
                (jsonDic) in
                print("OK")
                let code = jsonDic!["code"] as! Int
                let user_id = jsonDic!["user_id"] as! Int
                if code == 0 {
                    print("code = 0")
                    self.userId = user_id
                    self.performSegue(withIdentifier: "loginToSearch", sender: self)
                }
                else{
                    
                    let alertRegist = UIAlertController(title: "Confirm", message: "Login fail!!" , preferredStyle:.alert )
                    alertRegist.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alertRegist,animated: true)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SearchController
        vc.searchUserId = self.userId
    }
    @IBAction func Register(_ sender: Any) {
        let storeBroad: UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
        let vc = storeBroad.instantiateViewController(withIdentifier: "RegistController")
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
