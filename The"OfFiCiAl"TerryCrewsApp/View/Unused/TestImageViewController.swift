//
//  ViewController.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/16/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

class TestImageViewController: UIViewController {

    var vm: PokemonServiceViewModel!
    
    lazy var imageView: UIImageView = {
        let im = UIImageView(frame: .zero)
        im.setupToFill(superView: view)
        return im
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.bind {
            self.vm.image(at: 0) { (data) in
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                }
            }
        }
        vm.download("wailord")
    }

}

