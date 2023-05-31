//
//  FakeNetworkManager.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import Foundation
@testable import SportsApp
class FakeNetwork {
    
    var shouldReturnError: Bool
    let leaguesFakeResponse : LeguesResponse!  =  LeguesResponse(success: 1, result:[Legue(legueKey: 4, LegueName: "UEFA Europa League"),Legue(legueKey: 1, LegueName: "European Championship")] )
 
    let leagueDetailsFakeResponse:UpComingEventResponse! = UpComingEventResponse(result: [Result( eventDate: "2023-04-27"
                                                                                                 , homeTeamLogo:"https://apiv2.allsportsapi.com/logo/4974_fiorentina.jpg"
                                                                                                 , awayTeamLogo: "https://apiv2.allsportsapi.com/logo/4974_fiorentina.jpg"),
                                                                                         Result( eventDate: "2024-7-7", homeTeamLogo: " logo.png", awayTeamLogo: "awaylogo.png")], success: 1)
    
    
    
    let teamFakeResponse : TeamResponse! = TeamResponse(success: 1, result: [Team(teamKey: 1, teamName: "team1", teamLogo: "team1logo", players: nil, coaches: nil),
                                                                            Team(teamKey: 2, teamName: "team2", teamLogo: "team2logo", players: nil, coaches: nil)])
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
}

enum ResponseError : Error{
    case error
}



extension FakeNetwork : NetworkManagerType{
    
    func fetchLeguesLatestResults(url: String, compilitionHandler: @escaping (SportsApp.LeguesResponse?) -> Void) {
        if leaguesFakeResponse  == nil{
            
            compilitionHandler(nil)
        }
        else {
            compilitionHandler(leaguesFakeResponse)
        }
    }
    
    func fetchLegueTeams(url: String, compilitionHandler: @escaping (SportsApp.LeguesResponse?) -> Void) {
     
        guard let result = leaguesFakeResponse else{
            compilitionHandler(nil)
            return
        }
        compilitionHandler(result)
    }
    
    func fetchTeamDetails(url: String, compilitionHandler: @escaping (SportsApp.TeamResponse?) -> Void) {
        if teamFakeResponse  == nil{
            
            compilitionHandler(nil)
        }
        else {
            compilitionHandler(teamFakeResponse)
        }
    }
    
    func fetchLeguesUpCommingEvents(url: String, compilitionHandler: @escaping (SportsApp.UpComingEventResponse?) -> Void) {
        
        if leagueDetailsFakeResponse  == nil{
            
            compilitionHandler(nil)
        }
        else {
            compilitionHandler(leagueDetailsFakeResponse)
        }
        
    }

    func fetchLegues(url: String, compilitionHandler: @escaping (SportsApp.LeguesResponse?) -> Void) {
        if leaguesFakeResponse == nil{
            
            compilitionHandler(nil)
        }
        else {
            compilitionHandler(leaguesFakeResponse)
        }
        
    }
    
    
    
}


