//
//  TeamViewController.swift
//  SportsApp
//
//  Created by Mac on 30/05/2023.
//

import UIKit

class TeamViewController: UIViewController {

    var viewModel : TeamViewModel!
    var networkManager: NetworkManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = NetworkManager()
        viewModel = TeamViewModel(networkManager: networkManager)
        bindData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bindData()
    }
    
    func bindData(){
        
        self.viewModel?.bindTeamDetailsToViewController = {[weak self] in
            DispatchQueue.main.async {
               // self?.recipesTable.reloadData()
                print(self?.viewModel.getTeams().count ?? "No teams")
            }
        }
        
        viewModel.getTeamDetails(url:"\(footballUrl)\(API_KEY)")
  
    }

}
