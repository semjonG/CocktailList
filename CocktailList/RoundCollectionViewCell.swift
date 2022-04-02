//
//  RoundCollectionViewCell.swift
//  CocktailList
//
//  Created by mac on 01.04.2022.
//

import UIKit

class RoundCollectionViewCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var isTapped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ drink: Drink) {

        let words = drink.strDrink.components(separatedBy: .whitespacesAndNewlines).filter({!$0.isEmpty})
        
        if words.count > 2 {
            var copyText = drink.strDrink
            guard let firstWord = words.first else { return }
            let indexForBrakingLine = copyText.index(drink.strDrink.startIndex, offsetBy: firstWord.count)
            copyText.insert("\n", at: indexForBrakingLine)
            titleLabel.text = copyText
        } else {
            titleLabel.text = drink.strDrink
        }
        
        backgroundColor = isTapped ? .systemPink : .systemGray3
    }
    
    func tapped() {
       isTapped = !isTapped
    } 
}

// MARK: - Private
private extension RoundCollectionViewCell {
    
    func setup() {
        backgroundColor = .systemGray3
        
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.8
        layer.borderColor = UIColor.systemMint.cgColor
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension UIView {
      func addGradientBackground(firstColor: UIColor, secondColor: UIColor) {
          clipsToBounds = true
          let gradientLayer = CAGradientLayer()
          gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
          gradientLayer.frame = self.bounds
          gradientLayer.startPoint = CGPoint(x: 0, y: 0)
          gradientLayer.endPoint = CGPoint(x: 0, y: 1)
          print(gradientLayer.frame)
          self.layer.insertSublayer(gradientLayer, at: 0)
      }
  }
