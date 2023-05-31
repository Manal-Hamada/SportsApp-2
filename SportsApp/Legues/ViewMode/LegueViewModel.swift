//
//  LegueDetailsViewModel.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation

class LegueViewModel{
    
    var url : String!
    var networkManager : NetworkManagerType!
    var bindResultToViewController : (()->()) = {}
    var result : [Legue]!{
        didSet{
            bindResultToViewController()
        }
    }

 
    init(networkManager : NetworkManagerType){
        self.networkManager=networkManager
    }
    func fetchLegues(url:String){
        
        networkManager.fetchLegues(url: url) {  [weak self] (result : LeguesResponse?) in
           
            print(result?.result[0].country_name ?? "")
                self?.result = result?.result
                
  
        }
       
    }
    
 
}
