//
//  PokeTabBarController.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/18/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

class PokeTabBarController: UITabBarController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let firstVC = viewControllers![0] as! PokemonGalleryViewController
        firstVC.vm = appDelegate.factory.buildPokeServiceVM()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}
