//
//  ViewModel.swift
//  SportsApp
//
//  Created by Mac on 30/05/2023.
//

import Foundation

class FavouriteViewMoodel{
   
    var networkManager : LocalDbManagerType
    var legue : Legue!
    var bindFavLeguesToViewController: (() -> ())?
    var legues : [Legue]!
    
    init(networkManager : LocalDbManagerType ){
        
        self.networkManager = networkManager
    }
    
    func getLegues(){
        
        self.legues = networkManager.FetchLegues()
        self.bindFavLeguesToViewController
      
    }
    func getNumOfRowa() ->Int{
        
        return legues.count
    }
    
    func getLegue(row:Int) -> Legue{
        
        return legues[row]
    }
    
    func insertLegue(favLegue:Legue){
        
        networkManager.insertLegue(favLegue: favLegue)
        
    }
    
    func deleteLegue(legueName:String){
       
       networkManager.deleteLegue(legueName: legueName)
    }
    
}
