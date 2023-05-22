import UIKit
import Lottie
import Alamofire


class HomeViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
 
    @IBOutlet weak var homeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeLotties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = homeCollection.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 30.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(named: "darkBlue")?.cgColor
       // setAnimatedImg(animatedImg: cell.footballImg,fileName:homeLotties[indexPath.row].fileName)
        cell.img.image = UIImage(named: homeLotties[indexPath.row].fileName)
        setRoundedView(view: cell.name)
        cell.name.text = homeLotties[indexPath.row].name
        
        return cell
    }

    func setRoundedView(view:UIView){
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center
        rectShape.path = UIBezierPath(roundedRect:view.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 50, height: 50)).cgPath
        view.layer.mask = rectShape
    }
    
    func setAnimatedImg(animatedImg:LottieAnimationView,fileName:String){
       
          animatedImg.animation = LottieAnimation.named(fileName)
          animatedImg.contentMode = .scaleAspectFit
          animatedImg.loopMode = .loop
          animatedImg.animationSpeed = 0.5
          animatedImg.play()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width=UIScreen.main.bounds.width
        /*var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        homeCollection.collectionViewLayout = layout*/
        return CGSize(width:( width/2)-16.4, height: 180)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let legues = segue.destination as! LeguesViewController, index = homeCollection.indexPathsForSelectedItems?.first
        legues.headerTitle = homeLotties[index?.row ?? 0].name
        legues.url = urlEndPoints[index?.row ?? 0]
        
    }
}
