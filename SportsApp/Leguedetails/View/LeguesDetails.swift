import UIKit
import Kingfisher
import Alamofire

class LeguesDetails: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var favbtn: UIBarButtonItem!
    @IBOutlet weak var myCollection: UICollectionView!
    var upcomingEventUrl :String!
    var latestResultUrl :String!
    var teamsUrl :String!
    var favViewModel : FavouriteViewMoodel!
    var localDbManager:LocalDbManager!
    var legue : Legue!
    var upComingEvents : [Result]? = []
    var latestResult : [Result]? = []
    var teams : [Result]? = []
    var viewModel : ViewModel!
    var collectionLayout : UICollectionViewLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        viewModel = ViewModel()
        localDbManager = LocalDbManager.localDbManager
        favViewModel = FavouriteViewMoodel(networkManager: localDbManager)
        latestResult = [Result(),Result(),Result(),Result()]
        getLeguesEventData()
        getLeguesEventData()
        
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
                self?.latestResult = self?.viewModel.latestResult
                self!.myCollection.reloadData()
                
            }
            
        }
        viewModel.fetchLegueUpcommingEvents(url: upcomingEventUrl)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myCollection.reloadData()
        upComingEvents = viewModel.result
    }
    
    
    @IBAction func addToFavourite(_ sender: Any) {
        
        favbtn.image = UIImage(systemName: "suit.heart.fill")
        favViewModel.insertLegue(favLegue: legue)
    }
    
    func setLayout(){
        let layout = UICollectionViewCompositionalLayout{index, environment in
            
            switch index{
            case 0 :
                return /*self.drawTheTopSection()*/self.drawLatestResultSection()
                
            case 1:
                return self.drawLatestResultSection()
            default:
                return /*self.drawTeamsSection()*/self.drawLatestResultSection()
            }
            
        }
        
        
        myCollection.setCollectionViewLayout(layout, animated: true)
        
    }
    
    func drawTheTopSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(170))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 16, trailing: 0)
        
        /*  section.visibleItemsInvalidationHandler = { (items, offset, environment) in
         items.forEach { item in
         let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
         let minScale: CGFloat = 0.8
         let maxScale: CGFloat = 1.0
         let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
         item.transform = CGAffineTransform(scaleX: scale, y: scale)
         }
         }*/
        
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 70, trailing: 0)
        
        return section
    }
    
    func drawTeamsSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 16, trailing: 0)
        
        return section
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
            return teams?.count ?? 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0 :
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpComingEventCell
            
            let url1 = URL(string: upComingEvents?[indexPath.row].event_home_team ?? "")
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
            
            let url1 = URL(string: latestResult?[indexPath.row].event_home_team ?? "")
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
            // let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! teamCell
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! teamCell
            
            let url = URL(string: teams?[indexPath.row].event_home_team ?? "")
            cell.layer.cornerRadius = 30.0
            cell.teamImg.kf.setImage(with: url,placeholder: (UIImage(named: "sportslogo")))
            return cell
        }
        
    }
    
    
}

