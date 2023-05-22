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
var urlEndPoints = [footballUrl,basketballUrl,cricketUrl,tennisUrl]

var homeLotties = [HomeCell(fileName:"footballplayer",name: "Football"),HomeCell (fileName:"basketballplayer",name: "Basketball"),HomeCell(fileName:"cricketplayer",name: "Cricket"),HomeCell(fileName:"tennisplayer",name: "Tennis")]


