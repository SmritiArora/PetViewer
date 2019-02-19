//
//  ViewController.swift
//  Pet Viewer
//
//  Created by Smriti Arora on 09/02/19.
//  Copyright © 2019 Smriti Arora. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var pass: UITextField!
  
    @IBOutlet weak var stackview: UIStackView!
    
    @IBOutlet weak var button: UIButton!
    
    var myservice = ServiceWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        pass.delegate = self
        name.returnKeyType = UIReturnKeyType.next
        pass.returnKeyType = UIReturnKeyType.done
       }
    
    
    //going on second text field using keyboard return
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == name {
            pass.becomeFirstResponder()
        }
        if textField == pass
        {
            pass.becomeFirstResponder()
            pass.resignFirstResponder()
        }
        return true
    }
    
    
    // Alert Function
    func alert(msg: String){
        
        let alert=UIAlertController(title: "Pet Tinder says:", message: msg,preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Go Back", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //Validation Function

    func iscorrect() -> Bool
    {
        if name.text == "" && pass.text == ""
        {
            alert(msg: "Name and Password cannot be empty!")
            return false
        }
            
        else if name.text == "" && pass.text != ""
        {
            alert(msg: "Please input name!")
            return false
        }
        else if pass.text == "" && name.text != ""
        {
            alert(msg: "Please input password!")
            return false
        }
        else if button.isSelected
        {
            return true
        }
        else{
            alert(msg: "Agree to terms")
            return false
        }
    }
    
    let reachabilityManager = NetworkReachabilityManager()
  
    // Login request
    @ IBAction func request() {
      if iscorrect()
      {
        myservice.isconnected()
        { (connect) in
            if(connect == true)
                //Internet Available
             {
             let namex = self.name.text!
             let passx = self.pass.text!
             let url = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/login"
             let parameter = ["username" : namex ,"password" : passx]
             self.myservice.login(url: url, parameter: parameter)
                 { (token,status) in
                    if(status == 200)
                     {
                      //Storing session key
                      print(token)
                      UserDefaults.standard.set(token, forKey: "session")
                      //Segue Call to go on next view
                      self.performSegue(withIdentifier: "Secondsegue" , sender: self)
                     }
                   else
                    {
                    self.alert(msg: token)
                    }
                }
            }
           else {
                    self.alert(msg: "No Internet! Check your Connection.")
                    return
                }
        }// Connection check end
      } //IsCorrect end
    } //Request function end
        
    //Checkbox Image
    @IBAction func buttonin(_ sender: UIButton) {
        if(sender.isSelected == true) {
            sender.setBackgroundImage(UIImage(named: "checkoff"), for: .normal)
            sender.isSelected = false
        } else {
            sender.setBackgroundImage(UIImage(named: "checkon"), for: .selected)
            sender.isSelected = true
        }
    }
    
// View Controller Class end
}


