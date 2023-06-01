import UIKit
import Kingfisher
import Alamofire
import Lottie
//import Reachability


class LeguesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var legusTable: UITableView!   
    @IBOutlet weak var loading: LottieAnimationView!
    
    
    
    var url :String!
    var eventBaseUrl: String!
    var teamBaseUrl: String!
    var resultBaseUrl: String!
    var headerTitle:String!
    var viewModel : LegueViewModel!
    var networkManager : NetworkManagerType!
    var leguesList : Array<Legue>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leguesList = []
        print(url ?? "")
        self.displayCellView()
        networkManager = NetworkManager()
        viewModel = LegueViewModel(networkManager: networkManager)
        viewModel.bindResultToViewController = {[weak self ] in
            DispatchQueue.main.async { [self] in
                self?.loading.stop()
                self?.legusTable.isHidden = false
                self?.leguesList = self?.viewModel.result
                self!.legusTable.reloadData()
                
            }
        }
        
        /*  let reachability = try! Reachability()
         if reachability.connection != .unavailable{
         viewModel.fetchLegues(url: url)
         }
         else{
         let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "No Connection", preferredStyle: .alert)
         
         alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
         self.present(alert, animated: true, completion: nil)
         }*/
        
        viewModel.fetchLegues(url: url)
        
    }
    
    func displayCellView(){
        let nib = UINib(nibName: "LegueTableViewCell", bundle: nil)
        legusTable.register(nib, forCellReuseIdentifier: "LegueTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        playLottie()
        viewModel.fetchLegues(url: url)
        legusTable.reloadData()
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leguesList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = legusTable.dequeueReusableCell(withIdentifier: "LegueTableViewCell") as! LegueTableViewCell
        let url = URL(string:leguesList[indexPath.row].league_logo ?? "")
        
        
        cell.img.layer.cornerRadius = cell.img.frame.height / 2
        cell.img.layer.masksToBounds = false
        cell.img.clipsToBounds = true
        cell.img.kf.setImage(with:url,placeholder: (UIImage(named: "rlogo")))
        cell.name.text = leguesList[indexPath.row].league_name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "All \(headerTitle ?? "") Legues"
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          performSegue(withIdentifier: "segue", sender: self)
 
    
    }
    
    
    func playLottie(){
        legusTable.isHidden = true
        self.loading.contentMode = .scaleAspectFit
        self.loading.loopMode = .loop
        self.loading.animationSpeed = 0.5
        self.loading.play()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        getDate() // to set currentDate and plus year
        if  let events = segue.destination as? LeguesDetails{
            
            let selectedRow = leguesList[legusTable.indexPathForSelectedRow?.row ?? 0]
            
            events.upcomingEventUrl = eventBaseUrl
            events.latestResultUrl = resultBaseUrl
            events.teamsUrl = teamBaseUrl
            events.legue = selectedRow
            legusTable.deselectRow(at: legusTable.indexPathForSelectedRow!, animated: true)
            
            
            // self.present(events, animated: true,completion: nil)
            
        }
        
    }
    
    
    
}
