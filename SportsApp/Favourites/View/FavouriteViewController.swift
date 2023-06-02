//
//  FavouriteViewController.swift
//  SportsApp
//
//  Created by Mac on 19/05/2023.
//

import UIKit
import Kingfisher
import Lottie

class FavouriteViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var favTable: UITableView!
    @IBOutlet weak var empty: LottieAnimationView!
    
    
    var localDbManager:LocalDbManagerType!
    var viewModel : FavouriteViewMoodel!
    override func viewDidLoad() {
        super.viewDidLoad()
        localDbManager = LocalDbManager.localDbManager
        viewModel = FavouriteViewMoodel(networkManager: localDbManager)
        displayCellView()
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        viewModel.bindFavLeguesToViewController = {
            [weak self] in
            DispatchQueue.main.async {
                if (self!.viewModel.legues.count == 0){
                    //self?.playLottie()
                }else{
                 
                    self!.empty.stop()
                    self?.empty.isHidden = true
                    self!.favTable.isHidden = false
                }
                
                self?.favTable.reloadData()
            }
        }
        
        
        /*  let reachability = try! Reachability()
         if reachability.connection != .unavailable{
               viewModel.getLegues()
         }
         else{
         let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "No Connection", preferredStyle: .alert)
         
         alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
         self.present(alert, animated: true, completion: nil)
         }*/
        viewModel.getLegues()
        viewModel.bindFavModelsToViewController = {
            [weak self] in
            DispatchQueue.main.async {
     
            }
        }
        viewModel.getLegues()
        viewModel.getFavModels()
        favTable.reloadData()
    }
    
    func playLottie(){
        favTable.isHidden = true
        self.empty.contentMode = .scaleAspectFit
        self.empty.loopMode = .loop
        self.empty.animationSpeed = 0.5
        self.empty.play()
    
    }
 
    
    func displayCellView(){
        let nib = UINib(nibName: "LegueTableViewCell", bundle: nil)
        favTable.register(nib, forCellReuseIdentifier: "LegueTableViewCell")
  
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favSegue", sender: self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTable.dequeueReusableCell(withIdentifier: "LegueTableViewCell") as! LegueTableViewCell
        cell.img.layer.cornerRadius = cell.img.frame.height / 2
        cell.img.layer.masksToBounds = false
        cell.img.clipsToBounds = true
        let url = URL(string: viewModel.getLegue(row: indexPath.row).league_logo ?? "")
        cell.img.kf.setImage(with: url)
        cell.name.text = viewModel.getLegue(row:  indexPath.row).league_name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getNumOfRowa()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        let legueTobedeleted = viewModel.getLegue(row: indexPath.row)
       if editingStyle == .delete {
           
           let alert = UIAlertController(title: "Confirmation!", message: "Remove Legue..?", preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self]_ in
               self.viewModel.deleteLegue(legueName:legueTobedeleted.league_name ?? "")
               self.viewModel.getLegues()
               self.favTable.deleteRows(at: [indexPath], with: .automatic)
              
              
           }))
           alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:{_ in
               alert.dismiss(animated: true)
           }))
           
           self.present(alert, animated: true, completion: nil)
          
       }
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      

        getDate() // to set currentDate and plus year
        if  let events = segue.destination as? LeguesDetails{
            
            let favModel = viewModel.favModels[favTable.indexPathForSelectedRow?.row ?? 0]
            let selectedLegue = viewModel.legues[favTable.indexPathForSelectedRow?.row ?? 0]
            
            events.upcomingEventUrl = viewModel.getFavModel(row: favTable.indexPathForSelectedRow?.row ?? 0).eventUrl
            events.latestResultUrl = viewModel.getFavModel(row: favTable.indexPathForSelectedRow?.row ?? 0).resultUrl
            events.teamsUrl = viewModel.getFavModel(row: favTable.indexPathForSelectedRow?.row ?? 0).teamsUrl
            events.legue = selectedLegue
            favTable.deselectRow(at: favTable.indexPathForSelectedRow!, animated: true)
            
            
            // self.present(events, animated: true,completion: nil)
            
        }
        
    }
}
