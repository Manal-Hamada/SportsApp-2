
import Foundation

struct Result: Decodable  {

  var eventKey            : Int?      = nil
  var eventDate           : String?   = nil
  var eventTime           : String?   = nil
  var eventHomeTeam       : String?   = nil
  var homeTeamKey         : Int?      = nil
  var eventAwayTeam       : String?   = nil
  var awayTeamKey         : Int?      = nil
  var eventHalftimeResult : String?   = nil
  var eventFinalResult    : String?   = nil
  var eventFtResult       : String?   = nil
  var eventPenaltyResult  : String?   = nil
  var eventStatus         : String?   = nil
  var countryName         : String?   = nil
  var leagueName          : String?   = nil
  var leagueKey           : Int?      = nil
  var leagueRound         : String?   = nil
  var leagueSeason        : String?   = nil
  var eventLive           : String?   = nil
  var eventStadium        : String?   = nil
  var eventReferee        : String?   = nil
  var homeTeamLogo        : String?   = nil
  var awayTeamLogo        : String?   = nil
  var eventCountryKey     : Int?      = nil
  var leagueLogo          : String?   = nil
  var countryLogo         : String?   = nil
  var eventHomeFormation  : String?   = nil
  var eventAwayFormation  : String?   = nil
  var fkStageKey          : Int?      = nil
  var stageName           : String?   = nil
  var leagueGroup         : String?   = nil
  var goalscorers         : [String]? = []
  var substitutes         : [String]? = []
  var cards               : [String]? = []
  var lineups             : Lineups?  = Lineups()
  var statistics          : [String]? = []

  enum CodingKeys: String, CodingKey {

    case eventKey            = "event_key"
    case eventDate           = "event_date"
    case eventTime           = "event_time"
    case eventHomeTeam       = "event_home_team"
    case homeTeamKey         = "home_team_key"
    case eventAwayTeam       = "event_away_team"
    case awayTeamKey         = "away_team_key"
    case eventHalftimeResult = "event_halftime_result"
    case eventFinalResult    = "event_final_result"
    case eventFtResult       = "event_ft_result"
    case eventPenaltyResult  = "event_penalty_result"
    case eventStatus         = "event_status"
    case countryName         = "country_name"
    case leagueName          = "league_name"
    case leagueKey           = "league_key"
    case leagueRound         = "league_round"
    case leagueSeason        = "league_season"
    case eventLive           = "event_live"
    case eventStadium        = "event_stadium"
    case eventReferee        = "event_referee"
    case homeTeamLogo        = "home_team_logo"
    case awayTeamLogo        = "away_team_logo"
    case eventCountryKey     = "event_country_key"
    case leagueLogo          = "league_logo"
    case countryLogo         = "country_logo"
    case eventHomeFormation  = "event_home_formation"
    case eventAwayFormation  = "event_away_formation"
    case fkStageKey          = "fk_stage_key"
    case stageName           = "stage_name"
    case leagueGroup         = "league_group"
    case goalscorers         = "goalscorers"
    case substitutes         = "substitutes"
    case cards               = "cards"
    case lineups             = "lineups"
    case statistics          = "statistics"
  
  }

  
}
