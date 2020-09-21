//
//  ProductListController.swift
//  EcommApp
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Esha Pancholi. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

private let reuseIdentifier = "productcell"

enum countType {
    case views
    case share
    case ordered
}

class ProductListController: UICollectionViewController ,UICollectionViewDelegateFlowLayout  {

    @IBOutlet var collvc: UICollectionView!
    
    var categoryObj = rlmCategory()
    var arrproductlist = [rlmProduct]()
    var arrprodtypecount = [rlmRankProduct]()
    
    var iscountobj = false
    var prodlistType: countType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collvc.register(productcell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collvc.register(UINib(nibName:"productcell", bundle: nil), forCellWithReuseIdentifier:"productcell")

        self.setdatatoDisplay()

    }
    
    func setdatatoDisplay(){
    
        if iscountobj {
            
            let rlm = try! Realm()
            var predict:NSPredicate!
            var resultobj:Results<rlmRanking>
            
            if prodlistType == countType.views {
                
                
                predict = NSPredicate(format: " ranking == 'Most Viewed Products'")
                resultobj = rlm.objects(rlmRanking.self).filter(predict)
                
            }
            else if prodlistType == countType.ordered {
               
                let predict = NSPredicate(format: " ranking == 'Most OrdeRed Products'")
                resultobj = rlm.objects(rlmRanking.self).filter(predict)
                
            }
            else //if prodlistType == countType.ordered {
            {
                
                let predict = NSPredicate(format: " ranking == 'Most ShaRed Products'")
                resultobj = rlm.objects(rlmRanking.self).filter(predict)
                
            }
            
            var allids = [String]()
            for objs in resultobj.first!.products {
                allids.append(String(objs.id))
                arrprodtypecount.append(objs)
                
                let predict2 = NSPredicate(format: " id == %@",String(objs.id))
                let resultobj2 = rlm.objects(rlmProduct.self).filter(predict2)
                arrproductlist.append(resultobj2.first!)
                
            }
            self.collvc.reloadData()
        }
        else{
            arrproductlist = categoryObj.products.map{ $0 }
            self.collvc.reloadData()
        }
    }

   
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrproductlist.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! productcell

        
        let objProduct = arrproductlist[indexPath.item]
        cell.lblheader.text = objProduct.name
        cell.lblvariant.text = "\(objProduct.variant.count) variants"
        cell.btnviewmore.tag = indexPath.item
        
        cell.btnviewmore.addTarget(self, action: #selector(viewmoretapped(sender:)), for: .touchUpInside)
        
        cell.contentView.layer.borderColor = UIColor.systemGray2.cgColor
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.masksToBounds = true
        // Configure the cell
        
        if iscountobj {
            
            if prodlistType == countType.views {
                cell.imgtype.image = UIImage.init(named: "ic_view")
                cell.lblcount.text = "\(arrprodtypecount[indexPath.item].view_count)"
            }
            else if prodlistType == countType.ordered {
                cell.imgtype.image = UIImage.init(named: "ic_order")
                cell.lblcount.text = "\(arrprodtypecount[indexPath.item].order_count)"
            }
            else {
                cell.imgtype.image = UIImage.init(named: "ic_share")
                cell.lblcount.text = "\(arrprodtypecount[indexPath.item].shares)"
            }
        }
    
        return cell
    }

    @objc func viewmoretapped(sender: UIButton){
    
        let index = sender.tag
        let objProductatIndex = arrproductlist[index]
        
        let vc = self.initateVC(forSB: EJTextConst.ViewCnt.SIDMain, Vid: EJTextConst.ViewCnt.VidProduct) as! ProductViewController
        vc.objProduct = objProductatIndex
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
//        let wid = UIScreen.main.bounds.width/2 - 15
//        return CGSize(width: wid,height: 180)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let wid = (self.collvc.frame.size.width/2) - 25
        //let wid = (self.collvc.frame.size.width * 0.40)
        
        if iscountobj {
            return CGSize(width: wid ,height: 190)
        }
        else {
            return CGSize(width: wid ,height: 170)
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
