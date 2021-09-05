//
//  CocktailCellData.swift
//  Martini
//
//  Created by 최예주 on 2021/09/05.
//

// SearchBarView 구현을 위해 임시로 만듬(아마..)

import Foundation

class CocktailCellData{
    
    var cocktailName: String
    var strength: Double
    var cocktailImage: String
    var ingredient: String
    var description: String
    
    init(cName: String, cStrength: Double, cImage: String, cIngredient:String, cDescription: String) {
        
        cocktailName = cName
        strength = cStrength
        cocktailImage = cImage
        ingredient = cIngredient
        description = cDescription
    }
    
}
