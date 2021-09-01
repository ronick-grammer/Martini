//
//  PreferenceDataStore.swift
//  Martini
//
//  Created by RONICK on 2021/08/30.
//

import UIKit

struct PreferenceDataStore {
    static var alcohols: [Bool] = Array(repeating: false, count: Cocktail.Alcohol.allCases.count)
    
    static var ingredients: [Bool] = Array(repeating: false, count: Cocktail.Ingredients.allCases.count)
    
    static var taste: [Double] = Array(repeating: 0, count: Cocktail.Taste.TasteType.allCases.count)
}
