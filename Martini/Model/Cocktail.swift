//
//  Cocktail.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//

import UIKit
import FirebaseFirestoreSwift

struct Cocktail: Identifiable, Codable {
    
    
    enum Color: String, CaseIterable, Codable {
        case red
        case blue
        case green
        case yellow
        case teal
        case pink
        case orange
        case purple
        case none // 무색
        
        // 각 case의 인덱스
        var index: Self.AllCases.Index! {
            return Self.allCases.firstIndex { $0 == self }
        }
    }
    
    enum Alcohol: String, CaseIterable, Codable {
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
    }
    
    enum Ingredients: String, CaseIterable, Codable {
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
    }
    
    enum Taste: String, CaseIterable, Codable, CodingKey {

        case sweety
        case spicy
        case salty
        case creamy
        case bitter

        // 각 case의 인덱스
        var index: Self.AllCases.Index! {
            return Self.allCases.firstIndex { $0 == self }
        }
    }
    
    @DocumentID var id: String?

    let name: String
    let imgUrl: String
    let abv: Double // AlcoholByVolume (도수)
    let description: String
    let recipe: [String]
    let ingredients: [Ingredients]
    let base: Alcohol
    let color: [Color]
    let taste: [Taste:Int]
    
    var isLiked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imgUrl
        case base
        case color
        case abv  // AlcoholByVolume (도수)
        case ingredients
        case description
        case taste
        case recipe
    }
}



// 인코딩, 디코딩 구현
extension Cocktail {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self._id = try container.decode(DocumentID<String>.self, forKey: .id)
        self.abv = try container.decode(Double.self, forKey: .abv)
        self.base = try container.decode(Alcohol.self, forKey: .base)
        self.color = try container.decode([Color].self, forKey: .color)
        self.description = try container.decode(String.self, forKey: .description)
        self.ingredients = try container.decode([Ingredients].self, forKey: .ingredients)
        self.name = try container.decode(String.self, forKey: .name)
        self.recipe = try container.decode([String].self, forKey: .recipe)
        self.imgUrl = try container.decode(String.self, forKey: .imgUrl)

        // enum을 키로 가지는 딕셔너리 타입으로 변환하기
        let tasteContainer = try container.nestedContainer(keyedBy: Taste.self, forKey: .taste)

        var taste = [Taste: Int]()
        for key in tasteContainer.allKeys {
            guard let tasteKey = Taste(rawValue: key.rawValue) else {
                let context = DecodingError.Context(codingPath: [], debugDescription: "json 타입을 Taste 타입으로 변환 실패")
                throw DecodingError.dataCorrupted(context)
            }
            let value = try tasteContainer.decode(Int.self, forKey: key)
            taste.updateValue(value, forKey: tasteKey)
        }
        self.taste = taste
    }

    func encode(to encoder: Encoder) throws {

//      enum 을 key 로 가지는 딕셔너리는 파이어베이스에서 자료형으로 지원하지 않으므로 변환을 시켜줘야함
        let taste: [String: Int] = Dictionary(uniqueKeysWithValues: self.taste.map {
            (key: $0.rawValue, value: $1)
        })

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.abv, forKey: .abv)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.base, forKey: .base)
        try container.encode(self.color, forKey: .color)
        try container.encode(self.ingredients, forKey: .ingredients)
        try container.encode(self.recipe, forKey: .recipe)
        try container.encode(taste, forKey: .taste)
        try container.encode(self.imgUrl, forKey: .imgUrl)
    }
}
