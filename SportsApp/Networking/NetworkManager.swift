import Foundation
import Alamofire


protocol NetworkManagerType{
    func fetchLeguesUpCommingEvents(url:String,compilitionHandler: @escaping (UpComingEventResponse?) -> Void)
    func fetchLegues(url:String,compilitionHandler: @escaping (LeguesResponse?) -> Void)
    func fetchLeguesLatestResults(url:String,compilitionHandler: @escaping (LeguesResponse?) -> Void)
    //func fetchLegueTeams(url:String,compilitionHandler: @escaping (LeguesResponse?) -> Void)
    func fetchTeamDetails(url:String,compilitionHandler: @escaping (TeamResponse?) -> Void)
}
class NetworkManager :NetworkManagerType{
    
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
          
            compilitionHandler(teams)
            
            
        }
        
    }
}
