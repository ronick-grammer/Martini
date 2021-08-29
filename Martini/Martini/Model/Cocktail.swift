//
//  Cocktail.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//

import Foundation

struct Cocktail {
    enum color {
        case red
        case blue
        case green
    }
    
    enum Alcol{
        case rum
        case gin
        case whiskye
        case tequila
        case brandy
        case vodka
        case beer
        case soju
        case champagne
        case wine
        case none
    }
    
    enum Ingredients {
        case rum
        case gin
        case whiskye
        case tequila
        case brandy
        case vodka
        case beer
        case soju
        case champagne
        case wine
        case tonicWater
        case gingerAle
        case sugar
        case limeJuice
        case clubSodal
        case mint
        case olive
        case hot6
        case kahlua
        case milk
    }
    
    struct Taste {
        let sweety: Double
        let spicy: Double
        let solty: Double
        let creamy: Double
        let bitter: Double
    }
    
    let oid: String
    let name: String
    let base: Cocktail.Alcol
    let color: Cocktail.color
    let strength: Double
    let ingredients: [Cocktail.Ingredients]
    let description: String
    let taste: Taste
    let recipe: [String]
    
}
