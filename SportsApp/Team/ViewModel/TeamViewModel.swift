//
//  TeamViewModel.swift
//  SportsApp
//
//  Created by Mac on 30/05/2023.
//

import Foundation

protocol TeamViewModelType {
    
    var bindTeamDetailsToViewController : (()->())? { get set }
    
}
class TeamViewModel{
    
    var networkManager : NetworkManagerType!
    var team : Team!
    var bindTeamDetailsToViewController: (() -> ())?
    var teams : [Team]?
    
    init(networkManager:NetworkManagerType){
        self.networkManager = networkManager
      
    }
    
    func getTeamDetails(url:String){
        
        networkManager.fetchTeamDetails(url: url, compilitionHandler: { [weak self] (result : TeamResponse?) in
            
            self?.teams = result?.result ?? []
            self?.bindTeamDetailsToViewController
  
        })
        
    }
 
    func getNumOfRowa() ->Int{
        
        return teams?.count ?? 0
    }
    
    func getTeams() -> [Team]{
        
        return teams ?? []
    }
    
    func getTeam(row:Int)->Team{
        
        return (teams?[row])!
    }
    
}
