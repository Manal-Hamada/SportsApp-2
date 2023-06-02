import UIKit
import Kingfisher
import Alamofire
import Lottie

class LeguesDetails: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var favbtn: UIBarButtonItem!
    @IBOutlet weak var myCollection: UICollectionView!

    @IBOutlet weak var loading: LottieAnimationView!
    var upcomingEventUrl :String!
    var latestResultUrl :String!
    var teamsUrl :String!
    var favViewModel : FavouriteViewMoodel!
    var localDbManager:LocalDbManager!
    var teamViewModel : TeamViewModel!
    var networkManager : NetworkManagerType!
    var legue : Legue!
    var upComingEvents : [Result]? = []
    var latestResult : [Result]? = []
    var viewModel : ViewModel!
    var isFav : Bool = false
    var collectionLayout : UICollectionViewLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = NetworkManager()
        teamViewModel = TeamViewModel(networkManager: networkManager)
        playLottie()
        viewModel = ViewModel(networkManager: networkManager)
        localDbManager = LocalDbManager.localDbManager
        favViewModel = FavouriteViewMoodel(networkManager: localDbManager)
        getDate()
        print("latessssssss\(currentMinsYear)")
        upcomingEventUrl = "\(upcomingEventUrl ?? "")\(legue.league_key ?? 0)&from=\(currentDate)&to=\(currentDatePlusYear)&APIkey=\(API_KEY)"
        latestResultUrl = "\(latestResultUrl ?? "")\(legue.league_key ?? 0 )&from=\(currentMinsYear)&to=\(currentDate)&APIkey=\(API_KEY)"
        teamsUrl = "\(teamsUrl ?? "")\(legue.league_key ?? 0)&APIkey=\(API_KEY)"
        print("///////////////////////////////////////////////////////////")
        print(latestResultUrl ?? "latest resultn url")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myCollection.reloadData()
        isLegueFav()
        getTeams()
        getLeguesEventData()
        getLeguesLatestResultData()
        setLayout()
       

    }
    

func getLeguesEventData(){
    self.viewModel.bindEventsresultToViewController = {[weak self ] in
        DispatchQueue.main.async { [self] in
            self?.upComingEvents = self?.viewModel.result
            self!.myCollection.reloadData()
            
        }
        
    }
    viewModel.fetchLegueUpcommingEvents(url: upcomingEventUrl)
    
}

func getLeguesLatestResultData(){
    self.viewModel.bindLatestResultToViewController = {[weak self ] in
        DispatchQueue.main.async { [self] in
            self!.loading.stop()
            self?.loading.isHidden = true
            self!.myCollection.isHidden = false
            self?.latestResult = self?.viewModel.latestResult
            self!.myCollection.reloadData()
            
        }
        
    }
  
    viewModel.fetchLegueLatestResult(url: latestResultUrl)
    
}

    func getTeams(){
        
        self.teamViewModel?.bindTeamDetailsToViewController = {[weak self] in
            DispatchQueue.main.async {
                if self?.myCollection.isHidden == true {
                    
                }
                
                self!.myCollection.reloadData()
                print(self?.teamViewModel.getTeams().count ?? "No teams")
               
            }
           
        }
       
        teamViewModel.getTeamDetails(url:teamsUrl)
    
    }
    
    
    func playLottie(){
        myCollection.isHidden = true
        loading.contentMode = .scaleToFill
        loading.loopMode = .loop
        loading.animationSpeed = 0.5
        loading.play()
        
    
    }
    @IBAction func addToFavourite(_ sender: Any) {
   
        //let viewModel = FavouriteViewMoodel(networkManager: LocalDbManager.localDbManager)
        
        if isFav == false {
            
            favbtn.image = UIImage(systemName: "suit.heart.fill")
            favViewModel.insertLegue(favLegue: legue, upcomingEventUrl: upcomingEventUrl, latestResultUrl: latestResultUrl, teamsUrl: teamsUrl)
            isFav = true
            favViewModel.getLegues()
        }
        else{
            favbtn.image = UIImage(systemName: "suit.heart")
            
            let alert = UIAlertController(title: "Confirmation!", message: "Remove Legue..?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self]_ in
                self.favViewModel.deleteLegue(legueName:legue.league_name ?? "Un Known")
                isFav = false
                self.favViewModel.getLegues()
        
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:{_ in
                alert.dismiss(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
         
        }
    }
    
    func setLayout(){
        let layout = UICollectionViewCompositionalLayout{index, environment in
            
            switch index{
            case 0 :
                return self.drawTheTopSection()
                
                
            case 1:
                return self.drawLatestResultSection()
            default:
                return self.drawTeamsSection()
            }
            
        }
     
        myCollection.setCollectionViewLayout(layout, animated: true)
        
    }
    func isLegueFav(){
        
        let viewModel = FavouriteViewMoodel(networkManager: LocalDbManager.localDbManager)
        viewModel.getLegues()
        for legue in viewModel.legues{
            
            if legue.league_key == self.legue.league_key{
                self.favbtn.image = UIImage(systemName: "suit.heart.fill")
                isFav = true
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if indexPath.section == 2{
            
            let teamDetails = self.storyboard?.instantiateViewController(identifier: "teamDetals") as! TeamViewController
            
            teamDetails.team = teamViewModel.getTeam(row: indexPath.row)
            teamDetails.url = teamsUrl
            self.present(teamDetails, animated: true,completion: nil)
        }
       
    }
    
    func drawTheTopSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 16, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                       let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                       
                       section.boundarySupplementaryItems = [headerSupplementary]
        
        return section
    }
    
    func drawLatestResultSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(190))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                       let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                       
                       section.boundarySupplementaryItems = [headerSupplementary]
        
        return section
    }
    
    func drawTeamsSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension:  .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                       let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                       
                       section.boundarySupplementaryItems = [headerSupplementary]
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

           let  sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "detailsHeader", for: indexPath) as? Headers
               print("from section header")
           if kind == UICollectionView.elementKindSectionHeader {
                   
                   switch(indexPath.section){
                   case 0:
                       sectionHeader!.sectionHeader.text = "Upcoming Events"
                   case 1:
                       sectionHeader!.sectionHeader.text = "Latest Events"
                   default:
                       sectionHeader!.sectionHeader.text = "Teams"
                       
                   }
               }
           return sectionHeader!
       }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return upComingEvents?.count ?? 1
        case 1:
            return latestResult?.count ?? 1
        default :
            return teamViewModel.getTeams().count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0 :
            
          
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpComingEventCell
            
            let url1 = URL(string: upComingEvents?[indexPath.row].home_team_logo ?? "")
            let url2 = URL(string: upComingEvents?[indexPath.row] .away_team_logo ?? "")
            cell.layer.cornerRadius = 30.0
            cell.team1.layer.cornerRadius = cell.team1.frame.height / 4
            cell.team2.layer.cornerRadius = cell.team2.frame.height / 4
            cell.date.text = upComingEvents?[indexPath.row].event_date
            cell.eventtime.text = upComingEvents?[indexPath.row].event_time
            cell.team1Name.text = upComingEvents?[indexPath.row].event_home_team
            cell.team2Name.text = upComingEvents?[indexPath.row].event_away_team ?? "No name"
            cell.team1.kf.setImage(with:url1,placeholder: (UIImage(named: "sportslogo")))
            cell.team2.kf.setImage(with:url2,placeholder: (UIImage(named: "sportslogo")))
            print("home logo \(upComingEvents?[indexPath.row].home_team_logo ?? "No logos")")
            return cell
        case 1:
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! LatestResultCell
            
            let url1 = URL(string: latestResult?[indexPath.row].home_team_logo ?? "")
            let url2 = URL(string: latestResult?[indexPath.row] .away_team_logo ?? "")
            cell.layer.cornerRadius = 30.0
            cell.team1Logo.layer.cornerRadius = cell.team1Logo.frame.height / 4
            cell.team2Logo.layer.cornerRadius = cell.team2Logo.frame.height / 4
            cell.result.text = latestResult?[indexPath.row].event_final_result
            cell.date.text = latestResult?[indexPath.row].event_date
            cell.time.text = latestResult?[indexPath.row].event_time
            cell.team1Name.text = latestResult?[indexPath.row].event_home_team ?? "No name"
            cell.team2Name.text = latestResult?[indexPath.row].event_away_team ?? "No name"
            cell.team1Logo.kf.setImage(with:url1,placeholder: (UIImage(named: "sportslogo")))
            cell.team2Logo.kf.setImage(with:url2,placeholder: (UIImage(named: "sportslogo")))
            print("home logo \(latestResult?[indexPath.row].home_team_logo ?? "No logos")")
            return cell
            
        default :
         
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! teamCell
            cell.layer.cornerRadius = 20.0
            let team = teamViewModel.getTeam(row: indexPath.row)
            let url = URL(string: team.teamLogo ?? "")
            cell.teamImg.kf.setImage(with: url,placeholder: (UIImage(named: "sportslogo")))
            cell.teamImg.layer.cornerRadius = cell.teamImg.frame.height/2
            cell.teamName.text = team.teamName
            return cell
        }
        
    }
    
    
}

