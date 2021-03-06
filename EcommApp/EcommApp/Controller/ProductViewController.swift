//
//  ProductViewController.swift
//  EcommApp
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Esha Pancholi. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ProductViewController: UIViewController {

    var objProduct = rlmProduct()
    @IBOutlet weak var lblprodName: UILabel!
    @IBOutlet weak var imgprod: UIImageView!
    
    @IBOutlet weak var collsize: UICollectionView!
    @IBOutlet weak var lbltaxvalue: UILabel!
    @IBOutlet weak var lbltotalprice: UILabel!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setdatatoDisplay()
    }
    
    func setdatatoDisplay(){
        
        let rlm = try! Realm()
        let predict = NSPredicate(format: "id == %@","\(objProduct.id ?? "-")")
        let resultobj = rlm.objects(rlmProduct.self).filter(predict)
        
        print(resultobj.first as Any)
        let resultobjTax = rlm.objects(rlmTax.self).filter(predict)
        print(resultobjTax.first as Any)
        
        lblprodName.text = objProduct.name
        lbltaxvalue.text = "\(objProduct.tax?.name ?? "VAT"): \(objProduct.tax?.value ?? 0.0)"
        //lbltotalprice.text = "\(objProduct.variant[0].price ?? 0)"
        lbltotalprice.text = "Price: ₹\(objProduct.variant[0].price )"
        collsize.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return objProduct.variant.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collsize.dequeueReusableCell(withReuseIdentifier: "cellsize", for: indexPath)

        let objVar = objProduct.variant[indexPath.item]
        
        let lblcolor = cell.viewWithTag(10) as? UILabel
        lblcolor?.text = objVar.color
        let lblsize = cell.viewWithTag(11) as? UILabel
        lblsize?.text = "\(objVar.size )"
        
        let vwBg = cell.viewWithTag(12)
        
        if selectedIndex == indexPath.item {
            vwBg?.layer.borderColor = UIColor.systemOrange.cgColor
        }
        else
        {
            vwBg?.layer.borderColor = UIColor.clear.cgColor
            
        }
        vwBg?.layer.cornerRadius = 3.0
        vwBg?.layer.borderWidth = 1.5
        vwBg?.layer.masksToBounds = true
        
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.item
        collectionView.reloadData()
        let objVar = objProduct.variant[indexPath.item]
        lbltotalprice.text = "Price: ₹\(objVar.price )"
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 85,height: 70)
    }

}
