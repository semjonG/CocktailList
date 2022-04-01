//
//  CocktailModel.swift
//  CocktailList
//
//  Created by mac on 01.04.2022.
//

import Foundation

struct Cocktail: Decodable {
    var drinks: [Drink] 
}

struct Drink: Decodable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}
