
import Foundation

struct Lineups: Decodable  {

  var homeTeam : HomeTeam? = HomeTeam()
  var awayTeam : AwayTeam? = AwayTeam()

  enum CodingKeys: String, CodingKey {

    case homeTeam = "home_team"
    case awayTeam = "away_team"
  
  }

  

}
