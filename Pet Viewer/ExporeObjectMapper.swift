//
//  ExporeObjectMapper.swift
//  Pet Viewer
//
//  Created by Smriti Arora on 12/02/19.
//  Copyright © 2019 Smriti Arora. All rights reserved.
//

import Foundation
import ObjectMapper


class openblock: Mappable {
    
    var eresponse: eResponse?
    
    required init?(map: Map)
    {
        
    }
    
    func mapping(map: Map) {
        eresponse <- map["response"]
    }
}
    
    
    class eResponse: Mappable{
        
        var rdata: edata?
        var rstatus: estatus?
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            rdata <- map ["data"]
            rstatus <- map["status"]
        }
    }
    
    class edata: Mappable {
        
        var pets: [Pets]?
       
        required init?(map: Map){
            
        }
        
        func mapping(map: Map) {
          pets <- map["pets"]
        }
    }

    class Pets: Mappable{
        
        var ID: String?
        var Imgsrc: String?
        var Name: String?
        var Status: Bool?
        var Description: String?
        
        
        required init?(map: Map) {
            
        }
        
       func mapping(map: Map) {
        ID <- map ["_id"]
        Imgsrc <- map ["image"]
        Name <- map ["name"]
        Status <- map ["liked"]
        Description <- map ["description"]
        }

    }
    
    
    class estatus: Mappable {
        var code: Int?
        var message: String?
        
        required init?(map: Map){
            
        }
        
        func mapping(map: Map) {
            code <- map["code"]
            message <- map["message"]
        }
    }
    
