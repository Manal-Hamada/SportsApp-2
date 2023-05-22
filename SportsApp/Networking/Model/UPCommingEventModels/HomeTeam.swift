
import Foundation

struct HomeTeam: Decodable  {

  var startingLineups : [String]? = []
  var substitutes     : [String]? = []
  var coaches         : [String]? = []
  var missingPlayers  : [String]? = []

  enum CodingKeys: String, CodingKey {

    case startingLineups = "starting_lineups"
    case substitutes     = "substitutes"
    case coaches         = "coaches"
    case missingPlayers  = "missing_players"
  
  }


}
