import Foundation
import Alamofire

class ViewModel {
    
    var url : String!
    var latestResultUrl : String!
    var teamsUrl : String!
    var networkManager : NetworkManagerType!
    var bindEventsresultToViewController : (()->()) = {}
    var bindLatestResultToViewController : (()->()) = {}
    var bindTeamsToViewController : (()->()) = {}
    var result : [Result]!{
        didSet{
            bindEventsresultToViewController()
        }
    }
    var latestResult : [Result]!{
        didSet{
            bindLatestResultToViewController()
        }
    }
    var teamsresult : [Result]!{
        didSet{
            bindTeamsToViewController()
        }
    }
    
    init(networkManager:NetworkManagerType){
        
        self.networkManager=networkManager
    }
    
    func fetchLegueUpcommingEvents(url:String){
        
        networkManager.fetchLeguesUpCommingEvents(url: url) {  [weak self] (result : UpComingEventResponse?) in
            
            self?.result = result?.result
            
            
        }
        
    }
    
    
    func fetchLegueLatestResult(url:String){
        
        networkManager.fetchLeguesUpCommingEvents(url: url) {  [weak self] (result : UpComingEventResponse?) in
            
            print(result?.result[0].event_date ?? "ddddddddd")
            self?.latestResult = result?.result
            
            
        }
       
    }
    func fetchLegueTeams(url:String){
        
        networkManager.fetchLeguesUpCommingEvents(url: url) {  [weak self] (result : UpComingEventResponse?) in
            
            print(result?.result[0].event_date ?? "ddddddddd")
            self?.teamsresult = result?.result
            
            
        }
       
    }
}
