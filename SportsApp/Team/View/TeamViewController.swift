//
//  TeamViewController.swift
//  SportsApp
//
//  Created by Mac on 30/05/2023.
//

import UIKit

class TeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var teamtable: UITableView!
    @IBOutlet weak var teamLogo: UIImageView!
    
    var viewModel : TeamViewModel!
    var networkManager: NetworkManager!
    var team :Team!
    var url : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = NetworkManager()
        viewModel = TeamViewModel(networkManager: networkManager)
        bindData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bindData()
        let url = URL(string: team.teamLogo ?? "")
        teamLogo.kf.setImage(with: url ,placeholder: UIImage(named: "sportslogo"))
    }
    
    func bindData(){
        
        self.viewModel?.bindTeamDetailsToViewController = {[weak self] in
            DispatchQueue.main.async {
               // self?.recipesTable.reloadData()
                print(self?.viewModel.getTeams().count ?? "No teams")
            }
        }
        
        viewModel.getTeamDetails(url:"\(url ?? "")\(API_KEY)")
  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.players?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = teamtable.dequeueReusableCell(withIdentifier: "cell") as! TeamTableViewCell
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 20.0
        let player = team.players?[indexPath.row]
        cell.playerName.text = player?.playerName
        cell.playerposition.text = player?.playerType
        cell.redCard.text = "R:\(player?.playerRedCards ?? "")"
        cell.yelloCard.text = "Y:\(player?.playerYellowCards ?? "")"
        cell.tshirtNum.text = player?.playerNumber
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   /* func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
        let maskLayer = CALayer()
          maskLayer.cornerRadius = 10    //if you want round edges
          maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
          cell.layer.mask = maskLayer
    }*/
   
}
