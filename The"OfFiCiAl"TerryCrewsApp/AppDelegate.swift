//
//  AppDelegate.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/16/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let factory = PokeViewModelFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // what is my first VC?
        
        self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = chooseFirstVC()
        self.window?.makeKeyAndVisible()
        

        return true
    }
    
    func chooseFirstVC() -> UIViewController {
        let main = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController! = nil
        let trainer = factory.coreData.loadTrainerSynchronously()
        if let trainer = trainer {
            let tabVC = main.instantiateViewController(withIdentifier: "PokeTabBarController") as! PokeTabBarController
            // make a ViewModel for our ViewController
            // from our Factory.
            
            tabVC.firstVC.vm.trainer = trainer
            vc = tabVC
        }
        else {
            vc = main.instantiateViewController(withIdentifier: "TerrySelectPageViewController") as!
            TerrySelectPageViewController
        }
        self.window?.rootViewController = vc
        
        return vc
    }
    
    func getFirstVCOld() -> UIViewController {
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        // do some logic, decide the first VC
        if (Int.random(in: 0...1) == 0) {
            let vc = main.instantiateViewController(withIdentifier: "TestImageViewController") as! TestImageViewController
            // make a ViewModel for our ViewController
            // from our Factory.
            vc.vm = factory.buildPokeServiceVM()
            return vc
        }
        else {
            let vc = main.instantiateViewController(withIdentifier: "PokemonGalleryViewController") as! PokemonGalleryViewController
            vc.vm = factory.buildPokeServiceVM()
            return vc
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

