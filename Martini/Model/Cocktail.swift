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
    
    enum Alcol: Int, CaseIterable{
        case rum
        case gin
        case whisky
        case tequila
        case brandy
        case vodka
        case beer
        case soju
        case champagne
        case wine
        case none
        
        struct AlcolType {
            let fileName: String
            let title: String
        }
        
        var type: AlcolType {
            switch self {
            case .rum: return AlcolType(fileName: "rum", title: "럼")
            case .gin: return AlcolType(fileName: "gin", title: "진")
            case .whisky: return AlcolType(fileName: "whisky", title: "위스키")
            case .tequila: return AlcolType(fileName: "tequila", title: "데킬라")
            case .brandy: return AlcolType(fileName: "brandy", title: "브랜디")
            case .vodka: return AlcolType(fileName: "vodka", title: "보드카")
            case .beer: return AlcolType(fileName: "beer", title: "맥주")
            case .soju: return AlcolType(fileName: "soju", title: "소주")
            case .champagne: return AlcolType(fileName: "champagne", title: "샴페인")
            case .wine: return AlcolType(fileName: "wine", title: "와인")
            default: return AlcolType(fileName: "", title: "")
            }
        }
    }
    
    enum Ingredients: Int, CaseIterable {
        case rum
        case gin
        case whisky
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
        case clubSoda
        case mint
        case olive
        case hot6
        case kahlua
        case milk
        case none
        
        struct IngredientType {
            let fileName: String
            let title: String
        }
        
        var type: IngredientType {
            switch self {
            case .rum: return IngredientType(fileName: "rum", title: "럼")
            case .gin: return IngredientType(fileName: "gin", title: "진")
            case .whisky: return IngredientType(fileName: "whisky", title: "위스키")
            case .tequila: return IngredientType(fileName: "tequila", title: "데킬라")
            case .brandy: return IngredientType(fileName: "brandy", title: "브랜디")
            case .vodka: return IngredientType(fileName: "vodka", title: "보드카")
            case .beer: return IngredientType(fileName: "beer", title: "맥주")
            case .soju: return IngredientType(fileName: "soju", title: "소주")
            case .champagne: return IngredientType(fileName: "champagne", title: "샴페인")
            case .wine: return IngredientType(fileName: "wine", title: "와인")
            case .tonicWater: return IngredientType(fileName: "tonic", title: "토닉 워터")
            case .gingerAle: return IngredientType(fileName: "ginger ale", title: "진저 에일")
            case .sugar: return IngredientType(fileName: "sugar-cube", title: "라임 쥬스")
            case .limeJuice: return IngredientType(fileName: "lime-juice", title: "설탕")
            case .clubSoda: return IngredientType(fileName: "soda", title: "클럽 소다")
            case .mint: return IngredientType(fileName: "mint", title: "민트")
            case .olive: return IngredientType(fileName: "olives", title: "올리브")
            case .hot6: return IngredientType(fileName: "energy-drink", title: "에너지 드링크")
            case .kahlua: return IngredientType(fileName: "liqueur-coffee", title: "깔루아")
            case .milk: return IngredientType(fileName: "milk", title: "우유")
            default: return IngredientType(fileName: "", title: "")
            }
        }
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
