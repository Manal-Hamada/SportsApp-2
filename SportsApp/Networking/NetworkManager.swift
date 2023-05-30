import Foundation
import Alamofire
class NetworkManager{
    
    
    func fetchLeguesUpCommingEvents(url:String,compilitionHandler: @escaping (UpComingEventResponse?) -> Void) {
        
        let request = AF.request(url)
        request.responseDecodable(of:UpComingEventResponse.self) {  (response) in
            guard let events = response.value else {
                print("No response")
                return }
            print("from fetch \(String(describing: events.result[0].event_date) )")
            compilitionHandler(events)
            
            
        }
        
        
    }
    
    func fetchLegues(url:String,compilitionHandler: @escaping (LeguesResponse?) -> Void) {
        
        let request = AF.request(url)
        request.responseDecodable(of:LeguesResponse.self) { (response) in
            guard let events = response.value else {
                print("No response")
                return }
            print("from fetch \(String(describing: events.result[0].country_name) )")
            compilitionHandler(events)
            
            
        }
        
    }
    
    func fetchLeguesLatestResults(url:String,compilitionHandler: @escaping (LeguesResponse?) -> Void) {
        
        let request = AF.request(url)
        request.responseDecodable(of:LeguesResponse.self) { (response) in
            guard let events = response.value else {
                print("No response")
                return }
            print("from fetch \(String(describing: events.result[0].country_name) )")
            compilitionHandler(events)
            
            
        }
        
    }
    func fetchLegueTeams(url:String,compilitionHandler: @escaping (LeguesResponse?) -> Void) {
        
        let request = AF.request(url)
        request.responseDecodable(of:LeguesResponse.self) { (response) in
            guard let events = response.value else {
                print("No response")
                return }
            print("from fetch \(String(describing: events.result[0].country_name) )")
            compilitionHandler(events)
            
            
        }
        
    }
    
    func fetchTeamDetails(url:String,compilitionHandler: @escaping (TeamResponse?) -> Void){
       
        let request = AF.request(url)
        request.responseDecodable(of:TeamResponse.self) { (response) in
            guard let teams = response.value else {
                print("No response")
                return }
            print("from fetch teams \(String(describing: teams.result![0].players?.count)) ")
            compilitionHandler(teams)
            
            
        }
        
    }
}
