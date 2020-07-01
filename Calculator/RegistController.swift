//
//  RegistController.swift
//  Calculator
//
//  Created by Bui Cong Dai on 6/18/20.
//  Copyright © 2020 HoangHai. All rights reserved.
//

import UIKit

class RegistController: UIViewController {
    
   
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassWord: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    var loginClient = LoginClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmPassWord.addTarget(self, action: #selector(RegistController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    var url = "http://127.0.0.1:8000/rest/api/regist/requesters"
    var httpMethod = "POST"
    @IBAction func Register(_ sender: Any) {
        let usernametext = String(username.text!)
        let passwordtext = String(password.text!)
        let jsonInput = ["username": usernametext, "password":passwordtext]
        let confirmpasswordtext = String(confirmPassWord.text!)
        if(confirmpasswordtext == passwordtext){
            
            loginClient.Post(url,httpMethod,jsonInput){
            (json) in
            let code = json!["code"] as! Int
            if(code == 0){
                let alertRegist = UIAlertController(title: "Confirm", message: "Requester register success!" , preferredStyle:.alert )
                alertRegist.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alertRegist,animated: true)
            }
        }
        }else{
                
                let alertRegist = UIAlertController(title: "Confirm", message: "Confirm password false" , preferredStyle:.alert )
                          alertRegist.addAction(UIAlertAction(title: "OK", style: .cancel))
                          self.present(alertRegist,animated: true)
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        let storeBroad: UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
        let vc = storeBroad.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc, animated: true)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let passwordtext = String(password.text!)
        let confirmpasswordtext = String(confirmPassWord.text!)
        if passwordtext != confirmpasswordtext{
            let myColor = UIColor.red
            confirmPassWord.layer.borderColor = myColor.cgColor
            confirmPassWord.layer.borderColor = myColor.cgColor

            confirmPassWord.layer.borderWidth = 1.0
            confirmPassWord.layer.borderWidth = 1.0
            errorLabel.text = "Confirm password false"
            
        }
        else{
            let myColor = UIColor.black
            confirmPassWord.layer.borderColor = myColor.cgColor
            confirmPassWord.layer.borderColor = myColor.cgColor

            confirmPassWord.layer.borderWidth = 0
            confirmPassWord.layer.borderWidth = 0
            errorLabel.text = ""
            
        }
        
    }
    
}
