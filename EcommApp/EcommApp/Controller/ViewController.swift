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
        
    }
    
    func FetchDataFromLocal(){
        
    }
    
}

