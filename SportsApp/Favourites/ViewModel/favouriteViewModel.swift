//
//  ViewModel.swift
//  SportsApp
//
//  Created by Mac on 30/05/2023.
//

import Foundation

class FavouriteViewMoodel{
   
    var localManager : LocalDbManagerType
    var legue : Legue!
    var bindFavLeguesToViewController: (() -> ())?
    var bindFavModelsToViewController: (() -> ())?
    var legues : [Legue]!
    var favModels : [FavModel]!
    
    init(networkManager : LocalDbManagerType ){
        
        self.localManager = networkManager
    }
    
    func getLegues(){
        
        self.legues = localManager.FetchLegues()
        self.bindFavLeguesToViewController
      
    }
    
    func getFavModels(){
        
        self.favModels = localManager.fetchfavModels()
        self.bindFavModelsToViewController
      
    }
    func getFavModel(row:Int) -> FavModel{
        
        return favModels[row]
    }
    func getNumOfRowa() ->Int{
        
        return legues.count ?? 1
    }
    
    func getLegue(row:Int) -> Legue{
        
        return legues[row]
    }
    
 
    
    func insertLegue(favLegue: Legue,upcomingEventUrl:String,latestResultUrl:String,teamsUrl:String){
        
        localManager.insertLegue(favLegue: favLegue, eventsUrl: upcomingEventUrl, resultUrl: latestResultUrl, teamsUrl: teamsUrl)
        
    }
    
    func deleteLegue(legueName:String){
       
       localManager.deleteLegue(legueName: legueName)
    }
    
}
