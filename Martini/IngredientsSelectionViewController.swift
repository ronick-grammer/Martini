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
        
//        let cocktailColor = [Cocktail.Color.blue, Cocktail.Color.red, Cocktail.Color.teal]
//        let cocktailIngredient = [Cocktail.Ingredients.champagne, Cocktail.Ingredients.olive, Cocktail.Ingredients.tonicWater, Cocktail.Ingredients.mint, Cocktail.Ingredients.sugar]
//
//        var cocktailTaste =  [Cocktail.Taste:Int]()
//        for index in 0 ..< Cocktail.Taste.allCases.count {
//            cocktailTaste.updateValue(100 + (index * 6), forKey: Cocktail.Taste.allCases[index])
//        }
//
//        let recipe = [
//            "1. 깔루아를 잔에 깔아준다.",
//            "2. 그후 베이스인 샴페인을 넣고 원하는 색상을 두방을 떨어뜨린다.",
//            "3. 민트를 살포시 올려주면 완성!"
//        ]
//        
//        cocktailManager.registerCocktail("Martini", Cocktail.Alcohol.champagne, cocktailColor, 18.4, cocktailIngredient, "맛없는 칵테일로 최악의 하루를 선물하세요", cocktailTaste, recipe)
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
        let imageName = ingredient.type.imageName
        let title = ingredient.type.title
        
        cell.configure(imageName: imageName, title: title, index: ingredient.index)
        
        
        return cell
    }
}
