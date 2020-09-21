//
//  DetailViewController.swift
//  EcommApp
//
//  Created by apple on 18/09/20.
//  Copyright © 2020 Esha Pancholi. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tblview: UITableView!
    var categoriesObj = rlmCategory()
    var arrdetailCatList = [rlmCategory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupDisplaybyHeader()
    }
    
    func setupDisplaybyHeader(){
        
        
        print("child cate: \(categoriesObj.child_categories)")
        
        let rlm = try! Realm()
        let arrnew = rlm.objects(rlmCategory.self).filter("id IN %@",categoriesObj.child_categories)
        
        arrdetailCatList = arrnew.map{ $0 }
        self.tblview.reloadData()
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


extension DetailViewController :  UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrdetailCatList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
        let lblv = cell?.viewWithTag(10) as? UILabel
        
        let obj = arrdetailCatList[indexPath.row]
        lblv?.text = obj.name
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let objcategory = arrdetailCatList[indexPath.row]
        print("child cate: \(objcategory.child_categories)")
        
        if objcategory.child_categories.count > 0
        {
            let vc = self.initateVC(forSB: EJTextConst.ViewCnt.SIDMain, Vid: EJTextConst.ViewCnt.VidDetail) as! DetailViewController
            vc.categoriesObj = objcategory
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else // If has product list
        {
            let vc = self.initateVC(forSB: EJTextConst.ViewCnt.SIDMain, Vid: EJTextConst.ViewCnt.VidProductList) as! ProductListController
            vc.categoryObj = objcategory
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    
    
}
