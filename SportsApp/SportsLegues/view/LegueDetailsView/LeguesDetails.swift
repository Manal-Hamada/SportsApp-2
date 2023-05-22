//
//  LeguesDetails.swift
//  SportsApp
//
//  Created by Mac on 22/05/2023.
//

import UIKit

class LeguesDetails: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var myCollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
       
    }
    
    func setLayout(){
        let layout = UICollectionViewCompositionalLayout{index, environment in
            
            switch index{
              case 0 :
                return self.drawTheTopSection()
            
              case 1:
                return self.drawTheTopSection()
             case 2:
                return self.drawTheTopSection()
            default:
                return self.drawTheTopSection()
            }
         
        }
        myCollection.setCollectionViewLayout(layout, animated: true)
    }

    func drawTheTopSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
        
        return section
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = myCollection.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpComingEventCell
        
        
        
        return cell
    }
   
}
