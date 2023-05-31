//
//  UpComingEventsPojo.swift
//  SportsApp
//
//  Created by Mac on 23/05/2023.
//

import Foundation


class UpComingEventResponse : Decodable {
    
    var result : [Result]
    var success : Int?
    init(result: [Result], success: Int? ) {
        self.result = result
        self.success = success
    }
}

class Result : Decodable{
    var event_date : String?
    var event_time: String?
    var event_home_team : String?
    var event_away_team : String?
    var home_team_logo : String?
    var away_team_logo : String?
    var home_team_key : Int?
    var away_team_key : Int?
    var event_final_result : String?
    
    init(){}
    
    init(eventDate:String,homeTeamLogo:String,awayTeamLogo:String){
    
        self.event_date = eventDate
        self.home_team_logo = homeTeamLogo
        self.away_team_logo = awayTeamLogo
        
    }
    
    enum CodingKeys : String, CodingKey{
        case  event_date, event_time
        case event_home_team, event_away_team
        case home_team_logo
        case away_team_logo
        case home_team_key
        case away_team_key
        case event_final_result
        case event_home_team_logo, event_away_team_logo

        
        
      
        
    }
    required init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        self.event_date = try container.decodeIfPresent(String.self, forKey: .event_date)
        self.event_time = try container.decodeIfPresent(String.self, forKey: .event_time)
        self.event_home_team = try container.decodeIfPresent(String.self, forKey: .event_home_team)
        self.event_away_team = try container.decodeIfPresent(String.self, forKey: .event_away_team)
        self.home_team_key = try container.decodeIfPresent(Int.self, forKey: .home_team_key)
        self.away_team_key = try container.decodeIfPresent(Int.self, forKey: .away_team_key)
        self.home_team_logo = try container.decodeIfPresent(String.self, forKey: .home_team_logo) ?? container.decodeIfPresent(String.self, forKey: .event_home_team_logo)
        self.away_team_logo = try container.decodeIfPresent(String.self, forKey: .away_team_logo) ?? container.decodeIfPresent(String.self, forKey: .event_away_team_logo)
        self.event_final_result = try container.decodeIfPresent(String.self, forKey: .event_final_result)
    }
}

/*struct UpComingEventResponse : Decodable{
    var success: Int
    var result: [Result]
}

// MARK: - Result
struct Result :Decodable{
    var eventKey: Int
    var eventDate: String
    var eventTime: String
    var eventHomeTeam: String
    var homeTeamKey: Int
    var eventAwayTeam: String
    var awayTeamKey: Int
    var eventHalftimeResult, eventFinalResult, eventFtResult, eventPenaltyResult: String
    var eventStatus: String
    var countryName: String
    var leagueName: String
    var leagueKey: Int
    var leagueRound: String
    var leagueSeason: String
    var eventLive, eventStadium, eventReferee: String
    var homeTeamLogo, awayTeamLogo: String
    var eventCountryKey: Int
    var leagueLogo, countryLogo: String
    var eventHomeFormation, eventAwayFormation: String
    var fkStageKey: Int
    var stageName: String
    var leagueGroup: String?
    var goalscorers: [Goalscorer]
    var substitutes: [Substitute]
    var cards: [CardElement]
    var lineups: Lineups
    var statistics: [Statistic]
}

// MARK: - CardElement
struct CardElement :Decodable {
    var time, homeFault: String
    var card: String
    var awayFault, info, homePlayerID, awayPlayerID: String
    var infoTime: String
}


// MARK: - Goalscorer
struct Goalscorer :Decodable{
    var time, homeScorer, homeScorerID, homeAssist: String
    var homeAssistID, score, awayScorer, awayScorerID: String
    var awayAssist, awayAssistID: String
    var info: String
    var infoTime: String
}



// MARK: - Lineups
struct Lineups :Decodable{
    var homeTeam, awayTeam: Team
}

// MARK: - Team
struct Team : Decodable{
    var startingLineups, substitutes: [StartingLineup]
    var coaches: [Coach]
    var missingPlayers: [String?]
}

// MARK: - Coach
struct Coach : Decodable{
    var coache: String
    var coacheCountry: String
}

// MARK: - StartingLineup
struct StartingLineup :Decodable {
    var player: String
    var playerNumber, playerPosition: Int
    var playerCountry: String
    var playerKey: Int
    var infoTime: String
}

// MARK: - Statistic
struct Statistic :Decodable{
    var type, home, away: String
}

// MARK: - Substitute
struct Substitute :Decodable{
    var time: String
    var homeScorer: AwayScorerClass
    var homeAssist: String?
    var score: String
    var awayScorer: AwayScorerClass
    var awayAssist, info: String?
    var infoTime: String
}



// MARK: - AwayScorerClass
struct AwayScorerClass:Decodable {
    var scorerIn, out: String
    var inID, outID: Int
}
*/
