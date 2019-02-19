//
//  ObjectMapclass.swift
//  Pet Viewer
//
//  Created by Smriti Arora on 11/02/19.
//  Copyright © 2019 Smriti Arora. All rights reserved.
//

import Foundation
import ObjectMapper

class entryblock: Mappable {
    
    var response: Response?
    
    required init?(map: Map)
    {
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}
    

class Response: Mappable{
    
    var rdata: data?
    var rstatus: status?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        rdata <- map ["data"]
        rstatus <- map["status"]
    }
}
    
class data: Mappable {
    
        public var token: String?
        
        required init?(map: Map){
            
        }
        
        func mapping(map: Map) {
            token <- map["token"]
        }
    }
    
    
class status: Mappable {
        public var code: Int?
       public var message: String?
        
        required init?(map: Map){
            
        }
        
        func mapping(map: Map) {
            code <- map["code"]
            message <- map["message"]
        }
}

