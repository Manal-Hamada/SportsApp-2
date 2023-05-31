// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

class TeamResponse: Decodable {
    var success: Int?
    var result: [Team]?
    
    init(success: Int? , result: [Team]?) {
        self.success = success
        self.result = result
    }
}

class Team: Decodable {
    var teamKey: Int?
    var teamName: String?
    var teamLogo: String?
    var players: [Player]?
    var coaches: [CoachClass]?
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players = "players"
        case coaches = "coaches"
    }
    
    init(teamKey: Int?, teamName: String?, teamLogo: String?, players: [Player]?, coaches: [CoachClass]?) {
        self.teamKey = teamKey
        self.teamName = teamName
        self.teamLogo = teamLogo
        self.players = players
        self.coaches = coaches
    }
}

class CoachClass: Decodable {
    var coachName: String?
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
    
    
}

class Player: Decodable {
    var playerKey: Int?
    var playerName, playerNumber: String?
    var playerType: String?
    var playerAge, playerMatchPlayed, playerGoals, playerYellowCards: String?
    var playerRedCards: String?
    var playerImage: String?
    
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        case playerImage = "player_image"
    }
    
    
}

enum PlayerType: String, Codable {
    case defenders = "Defenders"
    case forwards = "Forwards"
    case goalkeepers = "Goalkeepers"
    case midfielders = "Midfielders"
}
/*struct TeamResponse: Decodable {
 var success: Int
 var result: [Team]
 }
 
 // MARK: - Result
 struct Team: Decodable {
 var teamKey: Int
 var teamName: String
 var teamLogo: String
 var players: [Player]
 var coaches: [Coach]
 
 enum CodingKeys: String, CodingKey {
 case teamKey = "team_key"
 case teamName = "team_name"
 case teamLogo = "team_logo"
 case players, coaches
 }
 }
 
 // MARK: - Coach
 struct Coach: Decodable {
 var coachName: String
 var coachCountry, coachAge: String
 
 enum CodingKeys: String, CodingKey {
 case coachName = "coach_name"
 case coachCountry = "coach_country"
 case coachAge = "coach_age"
 }
 }
 
 // MARK: - Player
 struct Player: Decodable {
 var playerKey: Int
 var playerName, playerNumber: String
 var playerCountry: String
 var playerType: String
 var playerAge, playerMatchPlayed, playerGoals, playerYellowCards: String
 var playerRedCards: String
 var playerImage: String?
 
 enum CodingKeys: String, CodingKey {
 case playerKey = "player_key"
 case playerName = "player_name"
 case playerNumber = "player_number"
 case playerCountry = "player_country"
 case playerType = "player_type"
 case playerAge = "player_age"
 case playerMatchPlayed = "player_match_played"
 case playerGoals = "player_goals"
 case playerYellowCards = "player_yellow_cards"
 case playerRedCards = "player_red_cards"
 case playerImage = "player_image"
 }
 }*/




