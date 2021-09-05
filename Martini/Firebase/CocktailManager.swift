//
//  CocktailController.swift
//  Martini
//
//  Created by RONICK on 2021/09/04.
//

import Firebase

class CocktailManager {
    var coktails =  [Cocktail] ()
    
    // 칵테일 정보 등록
    func registerCocktail(_ name: String, _ base: Cocktail.Alcohol, _ color: [Cocktail.Color], _ alcoholByVolume: Double, _ ingredients: [Cocktail.Ingredients], _ description: String, _ taste: [Cocktail.Taste:Int], _ recipe: [String]){
        
        let colorArrayData = color.map({ $0.rawValue })
        let ingredientsArrayData = ingredients.map({ $0.rawValue })
        
        var tasteMapData = [String:Int]()
        taste.forEach { key, value in
            tasteMapData.updateValue(value, forKey: key.rawValue)
        }
            
        let data = [
            "name": name,
            "base": base.rawValue,
            "color": colorArrayData,
            "abv": alcoholByVolume,
            "ingredient": ingredientsArrayData,
            "description": description,
            "taste": tasteMapData,
            "recipe": recipe
        ] as [String : Any]
        
        COLLECTION_COCKTAILS.addDocument(data: data) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
        }
        
    }
}
