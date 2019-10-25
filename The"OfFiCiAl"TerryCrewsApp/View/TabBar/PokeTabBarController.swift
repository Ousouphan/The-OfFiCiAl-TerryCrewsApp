//
//  PokeTabBarController.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/18/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

class PokeTabBarController: UITabBarController {

    var firstVC: PokemonGalleryViewController!
    var secondVC: PokedexViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let factory = appDelegate.factory
        
        firstVC = viewControllers![0] as? PokemonGalleryViewController
        firstVC.vm = factory.buildPokeServiceVM()
        
        secondVC = viewControllers![1] as? PokedexViewController
        secondVC.vm = factory.buildPokeServiceVM()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
