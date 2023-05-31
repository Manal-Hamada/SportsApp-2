//
//  Response.swift
//  SportsApp
//
//  Created by Mac on 19/05/2023.
//

import Foundation

class LeguesResponse : Decodable{
    
    var success:Int?
    var result: [Legue]
   
    init(success: Int?, result: [Legue]) {
        self.success = success
        self.result = result
    }

    
    enum CodingKeys: String, CodingKey{
        case success = "success"
        case result = "result"
     
      
    }
}

class Legue : Decodable {
    var league_key : Int?
    var league_name : String?
    var country_key : Int?
    var country_name : String?
    var league_logo : String?
    var country_logo : String?
    
    init(){}
    
    init(legueKey:Int,LegueName:String){
        self.league_key = legueKey
        self.league_name = LegueName
    }
}
