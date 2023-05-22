import UIKit
import Kingfisher
import Alamofire

class LeguesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
  
    

    @IBOutlet weak var legusTable: UITableView!
    var url :String!
    var headerTitle:String!
    var leguesList : Array<Legue>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leguesList = []
        print(url ?? "")
        fetchLegues(url: url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchLegues(url: url)
        legusTable.reloadData()
    }
    
    func fetchLegues(url:String) {
    
      let request = AF.request(url)
        request.responseDecodable(of:LeguesResponse.self) { (response) in
          guard let legus = response.value else { return }
            self.leguesList = legus.result
            print(legus.result[0].country_name ?? "Not found")
            self.legusTable.reloadData()
        }
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
        let cell = legusTable.dequeueReusableCell(withIdentifier: "leguuCell") as! LeguesableViewCell
        let url = URL(string:leguesList[indexPath.row].country_logo ?? "")
    
        
        cell.img.layer.cornerRadius = cell.img.frame.height / 2
        cell.img.layer.masksToBounds = false
        cell.img.clipsToBounds = true
        cell.img.layer.borderWidth = 0.5
        cell.img.layer.borderColor = UIColor(named: "darkBlue")?.cgColor
        cell.img.kf.setImage(with:url,placeholder: (UIImage(named: "loading")))
        cell.name.text = leguesList[indexPath.row].country_name
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "All \(headerTitle ?? "") Legues"
        
        
    }
}
