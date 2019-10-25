//
//  PokemonGalleryViewController.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/16/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

class PokemonGalleryViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var vm: PokemonServiceViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        vm.bind {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        vm.download("wailord")
        for _ in 0..<10 {
            vm.download("spheal")
        }
    }
    
}

extension PokemonGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return vm.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! PokeImageCollectionViewCell
        vm.image(at: indexPath.row) { (dat) in
            guard let dat = dat else { return }
            let image = UIImage(data: dat)
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
}

extension PokemonGalleryViewController: UICollectionViewDelegate {
    
}

extension PokemonGalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 3.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
