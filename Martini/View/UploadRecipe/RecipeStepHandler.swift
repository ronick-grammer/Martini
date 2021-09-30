//
//  RecipeStepHandler.swift
//  Martini
//
//  Created by RONICK on 2021/09/26.
//

import UIKit


extension UploadRecipeViewController {
    
    @objc func btn_addStep() {
        
        let stepCount = vStack_steps.arrangedSubviews.count + 1
        
        let recipeStep: RecipeTextView = {
            let textView = RecipeTextView()
            textView.recipeTextView.keyboardType = .namePhonePad
            textView.configure(number: String(stepCount))
            textView.translatesAutoresizingMaskIntoConstraints = false
            
            return textView
        }()
        
        recipeStep.recipeTextView.delegate = self
        
        if array_recipeTextView.count >= stepCount { // 전에 썼던 텍스트는 그대로 다시 보이게 함
            recipeStep.recipeTextView.text = array_recipeTextView[stepCount - 1].recipeTextView.text
            array_recipeTextView[stepCount - 1] = recipeStep
        } else {
            array_recipeTextView.append(recipeStep)
        }
        
        vStack_steps.addArrangedSubview(recipeStep)
        
        NSLayoutConstraint.activate([
            recipeStep.widthAnchor.constraint(equalTo: vStack_steps.widthAnchor),
            recipeStep.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func btn_removeStep() {
    
        let stepCount = vStack_steps.arrangedSubviews.count
        guard stepCount >= 2 else { return } // 하나 남은건 지우지 못하도록 함
        
        // 스택뷰에 있는 텍스트 뷰 지우기
        let last = vStack_steps.arrangedSubviews[stepCount - 1]
        vStack_steps.removeArrangedSubview(last)
        last.removeFromSuperview()
    }
}
