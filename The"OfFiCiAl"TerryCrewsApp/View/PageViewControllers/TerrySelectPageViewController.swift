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
    
    var currentVCIndex = 0
    var nextVCIndex = 0
    var pageIsAnimating = false
    
    var currTerry: (image: UIImage, name: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeVCs()
        
        delegate = self
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
            let vc = segue.destination as? PokemonGalleryViewController {
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
        }
    }
    
}
extension TerrySelectPageViewController: TerrySelectDelegate {
    func selectTerryAndContinue(_ terryInfo: (image: UIImage, name: String)) {
        performSegue(withIdentifier: "goToPokemonCaptureScreen", sender: nil)
    }
    
}

extension TerrySelectPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pageIsAnimating = true
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if finished || completed {
            pageIsAnimating = false
            currentVCIndex = nextVCIndex
        }
    }
    
}
extension TerrySelectPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if pageIsAnimating { return nil }
        
        // 1 -> 0
        if currentVCIndex == 0 {
            return nil
        }
        
        nextVCIndex = currentVCIndex - 1
        let vc = vcs[nextVCIndex]
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if pageIsAnimating { return nil }
        
        // 0 -> 1
        if currentVCIndex == vcs.count - 1 {
            return nil
        }
        
        nextVCIndex = currentVCIndex + 1
        let vc = vcs[nextVCIndex]
        return vc
    }
    
    
}
