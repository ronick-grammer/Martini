//
//  Cocktail.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//

import FirebaseFirestoreSwift
import UIKit

struct Cocktail: Identifiable, Decodable {
    
    
    enum Color: String, CaseIterable, Decodable {
        case red
        case blue
        case green
        case yellow
        case teal
        case pink
        case orange
        case none
        
        // 각 case의 인덱스
        var index: Self.AllCases.Index! {
            return Self.allCases.firstIndex { $0 == self }
        }
        
        struct ColorInfo {
            let title: String
            let color: UIColor
        }
        
        // 타입에 따른 정보 반환
        var type: ColorInfo {
            switch self {
            case .red   : return ColorInfo(title: "빨간색", color: .systemRed)
            case .blue  : return ColorInfo(title: "파란색", color: .systemBlue)
            case .green : return ColorInfo(title: "녹색", color: .systemGreen)
            case .yellow: return ColorInfo(title: "노란색", color: .systemYellow)
            case .teal  : return ColorInfo(title: "청록색", color: .systemTeal)
            case .pink  : return ColorInfo(title: "분홍색", color: .systemPink)
            case .orange: return ColorInfo(title: "주황색", color: .systemOrange)
            default     : return ColorInfo(title: "", color: UIColor())
                
            }
        }
    }
    
    enum Alcohol: String, CaseIterable, Decodable {
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
        case none // 비선택시
        
        // 각 case의 인덱스
        var index: Self.AllCases.Index! {
            return Self.allCases.firstIndex { $0 == self }
        }
        
        struct AlcoholInfo {
            let imageName: String
            let title: String
        }
        // 타입에 따른 정보 반환
        var type: AlcoholInfo {
            switch self {
            case .rum       : return AlcoholInfo(imageName: "rum", title: "럼")
            case .gin       : return AlcoholInfo(imageName: "gin", title: "진")
            case .whisky    : return AlcoholInfo(imageName: "whisky", title: "위스키")
            case .tequila   : return AlcoholInfo(imageName: "tequila", title: "데킬라")
            case .brandy    : return AlcoholInfo(imageName: "brandy", title: "브랜디")
            case .vodka     : return AlcoholInfo(imageName: "vodka", title: "보드카")
            case .beer      : return AlcoholInfo(imageName: "beer", title: "맥주")
            case .soju      : return AlcoholInfo(imageName: "soju", title: "소주")
            case .champagne : return AlcoholInfo(imageName: "champagne", title: "샴페인")
            case .wine      : return AlcoholInfo(imageName: "wine", title: "와인")
            default         : return AlcoholInfo(imageName: "", title: "")
            }
        }
    }
    
    enum Ingredients: String, CaseIterable, Decodable {
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
        case energyDrink
        case kahlua
        case milk
        case none // 비선택시
        
        // 각 case의 인덱스
        var index: Self.AllCases.Index! {
            return Self.allCases.firstIndex { self == $0 }
        }
        
        struct IngredientInfo {
            let imageName: String
            let title: String
        }
        // 타입에 따른 정보 반환
        var type: IngredientInfo {
            switch self {
            case .rum        : return IngredientInfo(imageName: "rum", title: "럼")
            case .gin        : return IngredientInfo(imageName: "gin", title: "진")
            case .whisky     : return IngredientInfo(imageName: "whisky", title: "위스키")
            case .tequila    : return IngredientInfo(imageName: "tequila", title: "데킬라")
            case .brandy     : return IngredientInfo(imageName: "brandy", title: "브랜디")
            case .vodka      : return IngredientInfo(imageName: "vodka", title: "보드카")
            case .beer       : return IngredientInfo(imageName: "beer", title: "맥주")
            case .soju       : return IngredientInfo(imageName: "soju", title: "소주")
            case .champagne  : return IngredientInfo(imageName: "champagne", title: "샴페인")
            case .wine       : return IngredientInfo(imageName: "wine", title: "와인")
            case .tonicWater : return IngredientInfo(imageName: "tonic", title: "토닉 워터")
            case .gingerAle  : return IngredientInfo(imageName: "ginger ale", title: "진저 에일")
            case .sugar      : return IngredientInfo(imageName: "sugar-cube", title: "설탕")
            case .limeJuice  : return IngredientInfo(imageName: "lime-juice", title: "라임 쥬스")
            case .clubSoda   : return IngredientInfo(imageName: "soda", title: "클럽 소다")
            case .mint       : return IngredientInfo(imageName: "mint", title: "민트")
            case .olive      : return IngredientInfo(imageName: "olives", title: "올리브")
            case .energyDrink: return IngredientInfo(imageName: "energy-drink", title: "에너지 드링크")
            case .kahlua     : return IngredientInfo(imageName: "liqueur-coffee", title: "깔루아")
            case .milk       : return IngredientInfo(imageName: "milk", title: "우유")
            default          : return IngredientInfo(imageName: "", title: "")
            }
        }
    }
    
    
    enum Taste: String, CaseIterable, Decodable {
        
        case sweety
        case spicy
        case salty
        case creamy
        case bitter
        case none // 비선택시
        
        // 각 case의 인덱스
        var index: Self.AllCases.Index! {
            return Self.allCases.firstIndex { $0 == self }
        }
        
        struct TasteInfo {
            let title: String
            let subtitle: String
        }
        // 타입에 따른 정보 반환
        var type: TasteInfo {
            switch self {
            case .sweety: return TasteInfo(title: "단맛", subtitle: "단맛이 강한 음료가 좋습니다")
            case .spicy : return TasteInfo(title: "매운맛", subtitle: "매운 맛을 좋아해요")
            case .salty : return TasteInfo(title: "짠맛", subtitle: "짭조름한 맛이 났으면 좋겠어요!")
            case .creamy: return TasteInfo(title: "부드러운맛", subtitle: "부드러운 맛이 있었으면 좋겠어요!")
            case .bitter: return TasteInfo(title: "술맛", subtitle: "술맛이 강했으면 좋겠어요")
            default     : return TasteInfo(title: "", subtitle: "")
            }
        }
    }
    
    
    @DocumentID var id: String?
    let name: String
    let base: Cocktail.Alcohol
    let color: [Cocktail.Color]
    let alcoholByVolume: Double
    let ingredients: [Cocktail.Ingredients]
    let description: String
    let taste: [Taste:Int]
    let recipe: [String]
    
}
