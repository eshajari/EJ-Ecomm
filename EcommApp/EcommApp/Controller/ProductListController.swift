//
//  ProductListController.swift
//  EcommApp
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Esha Pancholi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "productcell"

class ProductListController: UICollectionViewController {

    @IBOutlet var collvc: UICollectionView!
    
    var categoryObj = rlmCategory()
    var arrproductlist = [rlmProduct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        self.setdatatoDisplay()

    }
    
    func setdatatoDisplay(){
        
        arrproductlist = categoryObj.products.map{ $0 }
        self.collvc.reloadData()
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? productcell

        let objProduct = arrproductlist[indexPath.item]
        cell?.lblheader.text = objProduct.name
        cell?.lblvariant.text = "\(objProduct.variant.count) variants"
        cell?.btnviewmore.tag = indexPath.item
        
        cell?.btnviewmore.addTarget(self, action: #selector(viewmoretapped(sender:)), for: .touchUpInside)
        
        
        // Configure the cell
    
        return cell!
    }

    @objc func viewmoretapped(sender: UIButton){
    
        let index = sender.tag
        let objProductatIndex = arrproductlist[index]
        
        let vc = self.initateVC(forSB: EJTextConst.ViewCnt.SIDMain, Vid: EJTextConst.ViewCnt.VidProduct) as! ProductViewController
        vc.objProduct = objProductatIndex
        self.navigationController?.pushViewController(vc, animated: true)
        
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
