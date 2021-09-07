//
//  IngredientsSelectionViewController.swift
//  Martini
//
//  Created by RONICK on 2021/08/26.
//

import UIKit
import Firebase

class IngredientsSelectionViewController: UIViewController {
    
    @IBOutlet var ingredientsSelectionCollectionView: UICollectionView!
    @IBOutlet var btnPrev: UIButton!
    @IBOutlet var btnNext: UIButton!
    
    let identifier = "ingredientsSelectionCollectionViewCell"
    let spacingRow = 7
    let spacingColumn = 7
    
    
    let preferenceController =  PreferenceManager()
    let cocktailManager = CocktailManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsSelectionCollectionView.delegate = self
        ingredientsSelectionCollectionView.dataSource = self
        
        ingredientsSelectionCollectionView.register(IngredientsSelectionCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        btnPrev.layer.cornerRadius = 6
        btnPrev.titleLabel?.text = "이전"
        btnPrev.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        btnNext.layer.cornerRadius = 6
        btnNext.titleLabel?.text = "다음"
        btnNext.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    @IBAction func btnPreView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnNextView(_ sender: UIButton) {
        
        var bases = [String] ()
        var tastes = [String:Int]()
        var ingredients = [String] ()
        
        for index in 0 ..< PREFERENCE_DATASTORE.alcohols.count {
            if PREFERENCE_DATASTORE.alcohols[index] {
                bases.append(Cocktail.Alcohol.allCases[index].rawValue)
            }
        }
        
        for index in 0 ..< PREFERENCE_DATASTORE.ingredients.count {
            if PREFERENCE_DATASTORE.ingredients[index] {
                ingredients.append(Cocktail.Ingredients.allCases[index].rawValue)
            }
        }
        
        for index in 0 ..< PREFERENCE_DATASTORE.taste.count {
            tastes.updateValue(Int(PREFERENCE_DATASTORE.taste[index]), forKey: Cocktail.Taste.allCases[index].rawValue)
        }
        
        preferenceController.registerUserPreference(bases: bases, tastes: tastes, ingredients: ingredients)
        
        let cocktailColor = [Cocktail.Color.yellow, Cocktail.Color.orange]
        let cocktailIngredient = [Cocktail.Ingredients.gin, Cocktail.Ingredients.mint, Cocktail.Ingredients.mint, Cocktail.Ingredients.olive]

        var cocktailTaste =  [Cocktail.Taste:Int]()
        
        for index in 0 ..< Cocktail.Taste.allCases.count {
            cocktailTaste.updateValue(100 - (index * 13), forKey: Cocktail.Taste.allCases[index])
        }

        let recipe = [
            "1. 믹싱 글라스에 얼음을 가득 채우고 진을 부어준다.",
            "2. 30초 정도 잘 저어준다.",
            "3. 얼음이 걸러지게 스트레이너를 사용하여 준비된 마티니 잔에 부어준다",
            "4. 올리브 혹은 라임을 올려서 장식해준다!"
        ]
        
        cocktailManager.registerCocktail(cocktail: Cocktail(name: "Martini", base: Cocktail.Alcohol.gin, color: cocktailColor, abv: 14.9, ingredients: cocktailIngredient, description: "칵테일하면 마티니이다.", taste: cocktailTaste, recipe: recipe)) { success in

            print("cocktil success!!!! \(success)")
        }
    }
}


extension IngredientsSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(spacingRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(spacingColumn)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 화면에 최대 4행 4열의 셀만 보여주기
        let width = ingredientsSelectionCollectionView.bounds.width / 4 - CGFloat(spacingColumn)
        let height = ingredientsSelectionCollectionView.bounds.height / 4 - CGFloat(spacingRow)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(#function)
    }
}


extension IngredientsSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Cocktail.Ingredients.allCases.count - 1  // 마지막은 type은 없으므로 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ingredientsSelectionCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! IngredientsSelectionCollectionViewCell
        
        // 각 재료의 이미지 이름과 타이틀 이름으로 셀 만들기
        let ingredient = Cocktail.Ingredients.allCases[indexPath.row]
        let ingredientInfo = getIngredientInfo(ingredient: ingredient)
        let imageName = ingredientInfo.imageName
        let title = ingredientInfo.title
        
        cell.configure(imageName: imageName, title: title, index: ingredient.index)
        
        
        return cell
    }
    
    // 타입에 따른 정보 반환
    func getIngredientInfo(ingredient: Cocktail.Ingredients) -> IngredientInfo {
        switch ingredient {
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

struct IngredientInfo {
    let imageName: String
    let title: String
}
