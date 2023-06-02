//
//  Constants.swift
//  SportsApp
//
//  Created by Mac on 19/05/2023.
//

import Foundation

struct HomeCell{
    
    var fileName = ""
    var name = ""
}


var API_KEY = "a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0"
var footballUrl = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(API_KEY)"
var basketballUrl = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=\(API_KEY)"
var cricketUrl = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=\(API_KEY)"
var tennisUrl = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=\(API_KEY)"
var currentDate = ""
var currentDatePlusYear = ""
var currentMinsYear = ""
var upComingEventUrlBase = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId="
var upComingBasketBallEventUrlBase = "https://apiv2.allsportsapi.com/basketball?met=Fixtures&leagueId="
var upComingTennisEventUrlBase = "https://apiv2.allsportsapi.com/tennis?met=Fixtures&leagueId="
var upComingCricketEventUrlBase = "https://apiv2.allsportsapi.com/cricket?met=Fixtures&leagueId="
var footballTeamsBaseUrl = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId="
var basketballTeamsBaseUrl = "https://apiv2.allsportsapi.com/basketball/?&met=Teams&leagueId="
var tennisTeamsBaseUrl = "https://apiv2.allsportsapi.com/tennis/?&met=Teams&leagueId="
var cricketTeamsBaseUrl = "https://apiv2.allsportsapi.com/cricket/?&met=Teams&leagueId="
var urlEndPoints = [footballUrl,basketballUrl,cricketUrl,tennisUrl]

var homeLotties = [HomeCell(fileName:"fo",name: "Football"),HomeCell (fileName:"bas",name: "Basketball"),HomeCell(fileName:"cr",name: "Cricket"),HomeCell(fileName:"ten",name: "Tennis")]


func getDate(){
   
    let date = Date()
    let dateFormatter = DateFormatter()
    var dateComonent = DateComponents()
    var dateComonent2 = DateComponents()
    dateComonent.year = 1
    dateComonent2.year = -1
    
    dateFormatter.dateFormat = "yyyy-MM-dd"
    currentDate = dateFormatter.string(from: date)
    currentDatePlusYear = dateFormatter.string(from: Calendar.current.date(byAdding: dateComonent, to: date) ?? Date())
    currentMinsYear = dateFormatter.string(from: Calendar.current.date(byAdding: dateComonent2, to: date) ?? Date())
  
    print(currentDatePlusYear)

}
