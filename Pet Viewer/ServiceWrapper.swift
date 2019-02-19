//
//  ServiceWrapper.swift
//  Pet Viewer
//
//  Created by Smriti Arora on 18/02/19.
//  Copyright © 2019 Smriti Arora. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ServiceWrapper{
    
    init(){}
    func isconnected(finished: @escaping (Bool) -> Void)
    {
        let reachabilityManager = NetworkReachabilityManager()
        reachabilityManager?.startListening()
        reachabilityManager?.listener = { _ in
            if let isNetworkReachable = reachabilityManager?.isReachable,
                isNetworkReachable == true
            {
                finished(true)
            }
            else {
                finished(false)
            }
        }
    }
    
    
    func login(url: String,parameter: Dictionary< String,String>, finished: @escaping (String,Int) -> Void) {
        
        Alamofire.request(url, method: .post, parameters: parameter).responseObject
            {
                (response: DataResponse<entryblock>) in
                let loginresponse = response.result.value
                let Status = loginresponse?.response?.rstatus?.code
                if Status == 200
                {
                    let token = loginresponse?.response?.rdata?.token!
                    finished(token!,Status!)
                }
                else
                {
                    if(loginresponse?.response?.rstatus?.code == 404) {
                        finished("User not Found! Check Credentials.",Status!)
                    }
                }
        }
    }
    
 
    func get(url: String, finished: @escaping ([Pets]) -> Void) {
        
        let headers: HTTPHeaders = [ "Authorization" : UserDefaults.standard.string(forKey: "session")!
        ]
        
        Alamofire.request(url, headers: headers).responseObject
            { (response: DataResponse<openblock>) in
                let loginresponse = response.result.value
                if loginresponse?.eresponse?.rstatus?.code == 200
                {
                    if let newpets = loginresponse?.eresponse?.rdata?.pets
                    {
                        finished(newpets)
                    }
                }
           }
        
      }
    
    
    func update(Status: Bool, petId: String, url: String,finished: @escaping () -> Void)
    {
        let param = ["liked" : Status]
        let headers: HTTPHeaders = [ "Authorization" : UserDefaults.standard.string(forKey: "session")!
        ]
        
        Alamofire.request(url+petId, method: .put, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                response in
                switch response.result
                {
                case .success:
                    print("Done")
                    finished()
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    
    func logout(finished: @escaping (Int) -> Void){
        Alamofire.request("http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/logout",method: .post).responseJSON{
             response in
            switch response.result{
            case .success:
                print("Logged out")
                finished(1)
            case .failure:
                print("sdfewas")
                finished(0)
            }
        }
        
    }
    
    
}

