//
//  ViewController.swift
//  CocktailList
//
//  Created by mac on 01.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkManager = NetworkManager()

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
        //layout.minimumInteritemSpacing = 0.8
        //layout.minimumLineSpacing = 8
        layout.sectionInset = .init(top: 0, left: 4, bottom: 0, right: 4)
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
//    загуглить как переиспользуется how to reuse
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.roundCellIdentifier, for: indexPath) as? RoundCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(cocktails.drinks[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RoundCollectionViewCell else { return }
        collectionView.reloadItems(at: [indexPath])
        cell.tapped()
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

