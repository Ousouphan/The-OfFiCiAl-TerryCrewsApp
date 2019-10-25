//
//  TerrySelectPageViewController.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/18/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

class TerrySelectPageViewController: UIPageViewController {

    let names = ["essense",
                 "hotones",
                 "musclemusic",
                 "oldspice"]
    
    var vcs: [TerrySelectViewController] = []
    
    var currTerry: (image: UIImage, name: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeVCs()
        
        // delegate = self
        dataSource = self
        
        // what page do we start on?
        setViewControllers([vcs[0]],
                           direction: .forward,
                           animated: false,
                           completion: nil)
    }
    
    
    func makeVCs() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        for (i, name) in names.enumerated() {
            let vc = storyboard.instantiateViewController(withIdentifier: "TerrySelectViewController") as! TerrySelectViewController
            vc.image = UIImage(named: name)
            vc.name = name
            vc.terryId = i
            vc.delegate = self
            vcs.append(vc)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPokemonCaptureScreen",
            let vc = segue.destination as? PokemonGalleryViewController{
            // pass currTerry along.
            // to do to the next app, need to make... vm
            // vm comes from app Delegate
            
            // 1. access AppDelegate
            // 2. Make VM & give to VC
            // 3. Give Terry
            
            // 1.
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            // 2.
            let vm = appDelegate.factory.buildPokeServiceVM()
            vc.vm = vm
            
            // 3.
            // terry.
            if let terryInfo = sender as? (image: UIImage, name: String),
                let image = terryInfo.image.pngData() {
                vm.makeTrainer(name: terryInfo.name, image: image)
            }
        }
    }
    
}
extension TerrySelectPageViewController: TerrySelectDelegate {
    func selectTerryAndContinue(_ terryInfo: (image: UIImage, name: String)) {
        performSegue(withIdentifier: "goToPokemonCaptureScreen",
                     sender: terryInfo)
    }
    
}

extension TerrySelectPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currVC = viewController as! TerrySelectViewController
        
        // 1 -> 0
        if currVC.terryId == 0 {
            return nil
        }
        
        let vc = vcs[currVC.terryId - 1]
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currVC = viewController as! TerrySelectViewController
        
        // 0 -> 1
        if currVC.terryId == vcs.count - 1 {
            return nil
        }
        
        let vc = vcs[currVC.terryId + 1]
        return vc
    }
    
    
}
