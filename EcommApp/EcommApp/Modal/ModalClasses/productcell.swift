//
//  productcell.swift
//  EcommApp
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Esha Pancholi. All rights reserved.
//

import UIKit

class productcell: UICollectionViewCell {
    
    @IBOutlet weak var lblheader: UILabel!
    @IBOutlet weak var lblvariant: UILabel!
    @IBOutlet weak var btnviewmore: UIButton!
    
    @IBOutlet weak var imgtype: UIImageView!
    
    @IBOutlet weak var lblcount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
