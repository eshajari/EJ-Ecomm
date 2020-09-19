//
//  EJUtility.swift
//  EcommApp
//
//  Created by apple on 18/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import Reachability


class EJUtility: NSObject {
    
}

extension UIViewController {
    
    func showAlertonly(controller:UIViewController, withMessage message:String)
    {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: EJTextConst.Label.Ok, style: .default, handler: nil))
        
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlertandHandle(controller:UIViewController, withMessage message:String, andHandler handler:((UIAlertAction) -> Void)?)
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: EJTextConst.Label.Ok, style: .default, handler: handler))
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    
    
    func showProgressHUD()
    {
        SVProgressHUD.show(withStatus: "Loading...")
        //UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideProgressHUD()
    {
        //UIApplication.shared.endIgnoringInteractionEvents()
        SVProgressHUD.dismiss()
    }
    
    //Check Network
    func reachable() -> Bool
    {
        //let rechability = Reachability()
        let rechability = try! Reachability.init()
        do {
            
            if rechability.connection == .wifi || rechability.connection == .cellular {
                return true
            }else{
                return false
            }
        }
        //        catch {
        //            print("Unable to reach host!")
        //        }
    }
    
    func initateVC(forSB: String , Vid: String) -> UIViewController{
        
        let storyBoard: UIStoryboard = UIStoryboard(name: forSB, bundle: nil)
        let newVC = storyBoard.instantiateViewController(withIdentifier: Vid)

        return newVC
    }
    
}
