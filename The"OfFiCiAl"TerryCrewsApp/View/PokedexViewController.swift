//
//  PokedexViewController.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/25/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

class PokedexCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
}

private let cellID = "dexCell"

class PokedexViewController: UIViewController {
    
    // MARK: - Storyboard Outlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var vm: PokemonServiceViewModelProtocol!
    
    // ideally, I have a custom ViewModel solely for the Pokedex
    // to handle this behavior
    var startIndex = 1
    var maxResults = 9
    
    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        vm.bind {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        downloadMorePokemon()
    }
    
    func downloadMorePokemon() {
        var queries: [String] = []
        for i in startIndex...(startIndex+maxResults - 1) {
            queries.append(String(i))
        }
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.vm.batchDownload(queries)
        }
        */
        vm.batchDownload(queries)
        startIndex = startIndex + maxResults
    }
    
}

extension PokedexViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                                      for: indexPath) as! PokedexCollectionViewCell
        // get the mon, populate the cell with
        // the mon's details & image
        let mon = vm.pokemon(at: indexPath.row)
        cell.label.text = mon.name
        vm.image(at: indexPath.row) { (data) in
            DispatchQueue.main.async {
                if let data = data {
                    cell.imageView.image = UIImage(data: data)
                }
                else {
                    cell.imageView.image = nil
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == vm.count - 4 {
            downloadMorePokemon()
        }
    }
    
}

extension PokedexViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView
    }
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
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
