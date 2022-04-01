//
//  NetworkManager.swift
//  CocktailList
//
//  Created by mac on 01.04.2022.
//

import Alamofire

class NetworkManager {
    let baseURL = "https://www.thecocktaildb.com/api/json/"
    let endpoint = "v1/1/filter.php?a=Non_Alcoholic"
    
    func fetchCocktails(complition: @escaping (Cocktail) -> ()) {
        
        AF.request(baseURL + endpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
                
            case .success:
                guard let data = response.data else { return }
                let decodableCocktails = try! JSONDecoder().decode(Cocktail.self, from: data)
                complition(decodableCocktails)
            case .failure(let error):
                print(error)
            }
        }
    }
}



