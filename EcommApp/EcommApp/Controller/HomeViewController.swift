//
//  ViewController.swift
//  EcommApp
//
//  Created by apple on 18/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import Realm
import RealmSwift

class HomeViewController: UIViewController {
    
    var glbObjBaseCategory: RLMBaseCategory!
    var arrMainCat = [rlmCategory]()
    var arrRankingTypes = [rlmRanking]()
    
    @IBOutlet weak var tblview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CallAPIData()
    }
    
    
    
    
}

extension HomeViewController {
    
    func CallAPIData(){
        
        if self.reachable(){
            
            let apiReq = AF.request(EJTextConst.APIURL.apifetchAll)
            
            apiReq.responseData { (responseData) in
                
                do {
                    let decoder = JSONDecoder()
                    //decode json to Track class with Decodable protocol
                    let trackModel = try decoder.decode(BaseCategory.self, from: responseData.data!)
                    print("got data:\n \(trackModel)\n\n")
                    DispatchQueue.main.async {
                        
                        self.StoreDatatoLocal(baseObj: trackModel)
                    }
                    
                }
                catch let parsingError {
                    print("Error", parsingError)
                }
            }
            
        }
        else
        {
            self.showAlertonly(controller: self, withMessage: EJTextConst.Messages.connectionError)
        }
        
    }
    
    
    func StoreDatatoLocal(baseObj:BaseCategory){
        
        let realm = try! Realm()
        
        //Store by Catrgory
        for catobj in baseObj.categories {
            try! realm.write {
                //add the track classes with update set to true so you can easily call the server whenever needed.
                let objcat = rlmCategory.init()
                objcat.id = String(catobj.id)
                objcat.name = catobj.name
                
                for prod in catobj.products {
                    
                    let objprod = rlmProduct.init()
                    objprod.name = prod.name
                    objprod.id = String(prod.id)
                    objprod.date_added = prod.dateAdded
                    
                    let objtax = rlmTax.init()
                    objtax.value = prod.tax.value
                    objtax.name = prod.tax.name.rawValue
                    
                    objprod.tax = objtax
                    
                    for vari in prod.variants {
                        let objvari = rlmVariant.init()
                        objvari.id = vari.id
                        objvari.color = vari.color
                        objvari.size = vari.size
                        objvari.price = vari.price
                        
                        objprod.variant.append(objvari)
                    }
                    
                    objcat.products.append(objprod)
                }
                
                for numbs in catobj.childCategories {
                    objcat.child_categories.append(numbs)
                }
                
                //Final Obj add
                realm.add(objcat,update: .all)
            }
        }
        
        //Store for Ranking
        for rankingC in baseObj.rankings {
            try! realm.write {
                //add the track classes with update set to true so you can easily call the server whenever needed.
                //realm.add(obj)
                let objrankR = rlmRanking.init()
                objrankR.ranking = rankingC.ranking
                
                for rankprodC in rankingC.products {
                    
                    let objrankprodR = rlmRankProduct.init()
                    objrankprodR.id = rankprodC.id
                    objrankprodR.view_count = rankprodC.viewCount
                    objrankprodR.shares = rankprodC.shares
                    objrankprodR.order_count = rankprodC.orderCount
                    
                    objrankR.products.append(objrankprodR)
                    
                }
                
                //Final obj add
                realm.add(objrankR, update: .all)
                
            }
        }
        
        self.FetchDataFromLocal()
    }
    
    func FetchDataFromLocal(){
        
        let rlm = try! Realm()
        
        let rootCat = rlm.objects(rlmCategory.self)
        print("all cat:\n\(rootCat)")
        
        for obj in rootCat {
            print("obj: \(obj.name ?? "--")")
            
        }
        print("Now Actual:\n\\n")
        
        //let rootCat2 = rlm.objects(rlmCategory.self).filter("child_categories.@count > 0")
        let resultPredicate = NSPredicate(format: "products.@count == 0")
        let rootCat3 = rlm.objects(rlmCategory.self).filter(resultPredicate)
        
        
        var arrids = [Int]()
        for obj2 in rootCat3 {
            arrids.append(contentsOf:(obj2.child_categories))
        }
        print("all id:\(arrids)")
        
        
        //MARK: Get main categroy list
        self.arrMainCat = [rlmCategory]()
        //Check for root category
        for obj2 in rootCat3 {
            let val = Int(obj2.id!) ?? 0
            if !(arrids.contains(val)) {
                self.arrMainCat.append(obj2)
            }
        }
        
        self.tblview.reloadData()
        
        
        //MARK: Get rating category list
        let allranking = rlm.objects(rlmRanking.self)
        self.arrRankingTypes = [rlmRanking]()
        self.arrRankingTypes.append(contentsOf: allranking)
        
        
        self.tblview.reloadData()
        
    }
    
}



extension HomeViewController :  UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.arrMainCat.count
        }
        else{
            return self.arrRankingTypes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        let lblv = cell?.viewWithTag(10) as? UILabel
        
        if indexPath.section == 0 {
            let obj = arrMainCat[indexPath.row]
            lblv?.text = obj.name
        }
        else{
            let obj = self.arrRankingTypes[indexPath.row]
            lblv?.text = obj.ranking
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            // self.arrMainCat.count
            //pass details from the selected category data and list it from query
            
            let objcategory = arrMainCat[indexPath.row]
            print("child cate: \(objcategory.child_categories)")
            let vc = self.initateVC(forSB: EJTextConst.ViewCnt.SIDMain, Vid: EJTextConst.ViewCnt.VidDetail) as! DetailViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else{
            // self.arrRankingTypes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat(45.0)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Categories"
        case 1:
            return "Top Ranked"
        default: break
        }
        return ""
    }
    
}
