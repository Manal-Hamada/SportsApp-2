//
//  FavouriteLocalData.swift
//  SportsApp
//
//  Created by Mac on 30/05/2023.
//

import Foundation
import CoreData
import UIKit

protocol LocalDbManagerType{
    
    func insertLegue(favLegue:Legue,eventsUrl:String,resultUrl:String,teamsUrl:String)
    func FetchLegues()->Array<Legue>
    func fetchfavModels()->Array<FavModel>
    func deleteLegue(legueName:String)
}

class LocalDbManager : LocalDbManagerType{
    
    var entityName = "Favourites"
    
    var manager : NSManagedObjectContext?
    var favLegues : [NSManagedObject] = []
    var favModels : [NSManagedObject] = []
    var legueToBeDeleted : NSManagedObject?
    static var localDbManager = LocalDbManager()
    
    private init(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    func insertLegue(favLegue:Legue,eventsUrl:String,resultUrl:String,teamsUrl:String){
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: manager! )
        let legue = NSManagedObject(entity: entity!, insertInto: manager)
        
        legue.setValue(favLegue.league_key, forKey: "legueKey")
        legue.setValue(favLegue.league_name, forKey: "legueName")
        legue.setValue(favLegue.league_logo, forKey: "legueLogo")
        legue.setValue(eventsUrl, forKey: "eventUrl")
        legue.setValue(resultUrl, forKey: "resultUrl")
        legue.setValue(teamsUrl, forKey: "teamsUrl")
        
        legue.setValue(true, forKey: "isFav")
        
        do{
            try manager!.save()
            
            print("Saved!")
        }catch let error{
            print("Cannot save legue")
            print(error.localizedDescription)
        }
    }
    func FetchLegues()->Array<Legue>{
        let fetch = NSFetchRequest<NSManagedObject>(entityName:entityName)
        var legues :Array<Legue>=[]
        
        do{
            favLegues = try manager!.fetch(fetch)
            print(legues.count)
            for item in favLegues{
                legues.append(setLegueData(item: item))
                
            }
            
        }
        
        catch let error{
            print(error.localizedDescription)
        }
        
        return legues
    }
    
    func fetchfavModels()->Array<FavModel>{
        let fetch = NSFetchRequest<NSManagedObject>(entityName:entityName)
        var legues :Array<FavModel>=[]
        
        do{
            favModels = try manager!.fetch(fetch)
            print(legues.count)
            for item in favModels{
                legues.append(setFavLeguUrls(item: item))
                
            }
            
        }
        
        catch let error{
            print(error.localizedDescription)
        }
        
        return legues
    }
    
    func setLegueData(item:NSManagedObject)->Legue{
        
        let legue = Legue()
        
        legue.league_logo = item.value(forKey: "legueLogo") as? String
        legue.league_name = item.value(forKey: "legueName") as? String
        legue.league_key = item.value(forKey: "legueKey") as? Int
        
        return legue
    }
    
    func deleteLegue(legueName:String){
        let fetch = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        // predicate
        let predicate = NSPredicate(format: "legueName == %@", legueName)
        
        fetch.predicate = predicate
        do{
            favLegues = try manager!.fetch(fetch)
            if(favLegues.count > 0){
                legueToBeDeleted = favLegues.first
            }
        }catch let error{
            print(error.localizedDescription)
        }
        guard let legue = legueToBeDeleted else{
            print("cannot be deleted!")
            return
        }
        manager!.delete(legue)
        do{
            try manager!.save()
            print("Deleted!")
            legueToBeDeleted = nil
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    func setFavLeguUrls(item:NSManagedObject)->FavModel{
        
        let legue = FavModel()
        
        legue.eventUrl = (item.value(forKey: "eventUrl") as? String) ?? ""
        legue.resultUrl = (item.value(forKey: "resultUrl") as? String) ?? ""
        legue.teamsUrl = (item.value(forKey: "teamsUrl") as? String) ?? ""
       
        
        return legue
    }
}
