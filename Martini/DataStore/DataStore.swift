//
//  PreferenceDataStore.swift
//  Martini
//
//  Created by RONICK on 2021/08/30.
//

import UIKit

enum RegistrationType {
    case user
    case cocktail
}

struct DataStore {
    
    var user: User?
    
    // 현재 유저의 선호도 데이터 가져오기
    mutating func initializeUserPreference(user: User) {
        self.user = user
        
        
        // 아무것도 선택하지 않았으면 초기화
        if self.user?.basePreference == nil {
            self.user?.basePreference = [Cocktail.Alcohol] ()
        }
        
        if self.user?.ingredientPreference == nil {
            self.user?.ingredientPreference = [Cocktail.Ingredients] ()
        }
        
        // taste 같은 경우는 모든 맛의 선호도를 반드시 가지고 있어야 하므로
        if self.user?.tastePreference == nil {
            self.user?.tastePreference = [String:Int] ()
            for tasteType in Cocktail.Taste.allCases {
                self.user?.tastePreference?.updateValue(0, forKey: tasteType.rawValue)
            }
        }
    }
}

struct CocktailDataStore {
    var name: String
    var imgUrl: String
    var abv: Double // AlcoholByVolume (도수)
    var description: String
    var recipe: [String]
    var ingredients: [Cocktail.Ingredients]
    var base: Cocktail.Alcohol?
    var color: [Cocktail.Color]
    var taste: [Cocktail.Taste:Int]
    
    var selectedBase: Bool {
        get {
            return base != nil
        }
    }
    
    var selectedIngredient: Bool {
        get {
            return !ingredients.isEmpty
        }
    }
    
    var selectedColor: Bool {
        get {
            return !color.isEmpty
        }
    }
    
    var selectedTaste: Bool {
        get {
            var selected = false
            for tasteType in Cocktail.Taste.allCases {
                if taste[tasteType] != 0 {
                    selected = true
                    break
                }
            }
            return selected
        }
    }
    
    init() {
        self.name = ""
        self.imgUrl = ""
        self.abv = 0
        self.description = ""
        self.recipe = [String]()
        self.ingredients = [Cocktail.Ingredients]()
        self.base =  nil
        self.color = [Cocktail.Color]()
        
        self.taste = [Cocktail.Taste:Int]()
        for tasteType in Cocktail.Taste.allCases {
            self.taste.updateValue(0, forKey: tasteType)
        }
    }
    
    init(name: String, imgUrl: String, abv: Double, description: String, recipe: [String], ingredients: [Cocktail.Ingredients], base: Cocktail.Alcohol, color: [Cocktail.Color], taste: [Cocktail.Taste : Int]) {
        self.name = name
        self.imgUrl = imgUrl
        self.abv = abv
        self.description = description
        self.recipe = recipe
        self.ingredients = ingredients
        self.base = base
        self.color = color
        self.taste = taste
    }
}

var DATASTORE = DataStore()

var DATASTORE_COCKTAIL: CocktailDataStore?
