//
//  ViewController.swift
//  CocktailList
//
//  Created by mac on 01.04.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    private let selectedIndexes = NSMutableSet()

    private enum Constants {
        static let roundCellIdentifier = "roundCellIdentifier"
    }
    
    private var cocktails = Cocktail(drinks: []) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 8, bottom: 0, right: -8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RoundCollectionViewCell.self, forCellWithReuseIdentifier: Constants.roundCellIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        let layout = TagFlowLayout()
        collectionView.collectionViewLayout = layout
        
        networkManager.fetchCocktails { [weak self] cocktails in
            self?.cocktails = cocktails
        }
    }
    
    func setup() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktails.drinks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.roundCellIdentifier, for: indexPath) as? RoundCollectionViewCell else { return UICollectionViewCell() }
        
        selectedIndexes.contains(indexPath) == true ? cell.tapped(true) : cell.tapped(false)
        cell.configure(cocktails.drinks[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RoundCollectionViewCell else { return }
        
        if selectedIndexes.contains(indexPath) {
            selectedIndexes.remove(indexPath)
            cell.tapped(false)
        } else {
            selectedIndexes.add(indexPath)
            cell.tapped(true)
        }
        cell.configure(cocktails.drinks[indexPath.item])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = cocktails.drinks[indexPath.row]
        let size = data.strDrink.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20,weight: .medium)
        ])
        return CGSize(width: size.width, height: 48)
    }
}

