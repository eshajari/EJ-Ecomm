//
//  EJTextConst.swift
//  EcommApp
//
//  Created by apple on 18/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation

struct EJTextConst
{
    struct Label
    {
        static let Ok          = "OK"
        static let Done        = "Done"
        static let Cancel      = "Cancel"
       
    }
    
    struct Key
    {
        static let appName     = "Ecommerce"
        static let appLanguage = "applanguage"
        static let appMessages = "appmessages"
        static let X_API_KEY = "X-API-KEY"
        
        static let catdatastored = "catDataStored"
    }
    
    
    struct Messages {
        
        static let connectionError = "Network connection is not available!"
        
        
    }
    
    struct APIURL {
        static let apifetchAll = "https://stark-spire-93433.herokuapp.com/json"
    }
    
    struct ViewCnt {
        static let SIDMain = "Main"
        
        
        static let VidHome = "IDHomeViewController"
        static let VidDetail = "IDDetailViewController"
        static let VidProduct = "IDProductViewController"
    }
}
