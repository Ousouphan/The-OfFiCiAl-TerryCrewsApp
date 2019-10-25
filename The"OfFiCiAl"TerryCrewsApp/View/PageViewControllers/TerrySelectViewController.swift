//
//  TerrySelectViewController.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/18/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

protocol TerrySelectDelegate {
    func selectTerryAndContinue(_ terryInfo: (image: UIImage, name: String))
}

class TerrySelectViewController: UIViewController {

    // MARK: - Storyboard IBOutlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    // MARK: - Properties
    
    var delegate: TerrySelectDelegate?
    var image: UIImage?
    var name: String?
    var terryId: Int = 0 // the index of the Terry
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        label.text = name
    }
    
    // MARK: Custom Action Methods
    
    @IBAction func buttonAction(_ sender: Any) {
        // selects the terry.
        delegate?.selectTerryAndContinue((image: image!, name: name!))
    }
}
