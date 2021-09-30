//
//  UploadRecipeTextDelegate.swift
//  Martini
//
//  Created by RONICK on 2021/09/26.
//

import UIKit


extension UploadRecipeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        activeView = textField // 현재 작성중인 텍스트 박스 저장
        
        // 스크롤 뷰 영역 기준의 bounds 로 변환
        activeBounds = textField.convert(textField.bounds, to: scrollView)
        
        return true
    }
    
   func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        // 텍스트 필드 작성 중에 바로 다른 텍스트 필드 작성 시도시,
        // activeView는 새로 작성 시도된 텍스트필드로 설정되었으므로 이 둘을 구분해야 한다.
        // 위의 매개변수 textField는 작성(edit)이 종료(end)된 텍스트필드이지만,
        // textField 에서 activeView 로 작성 상태가 '곧바로' 옮겨간 것이기 때문에
        // 키보드를 내리면(dismiss) 안된다.
        guard textField == activeView else { return true }
        
        activeView?.resignFirstResponder()
        activeView = nil
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}


// MARK: UITextFieldDelegate
extension UploadRecipeViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceHolder.isHidden = !cocktailDescription.text.isEmpty
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        activeView = textView // 현재 작성중인 텍스트 박스 저장
        
        // 스크롤 뷰 영역 기준의 bounds 로 변환
        activeBounds = textView.convert(textView.bounds, to: scrollView)
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        // 텍스트 뷰 작성 중에 바로 다른 텍스트 뷰 작성 시도시,
        // activeView는 새로 작성 시도된 텍스트뷰로 설정되었으므로 이 둘을 구분해야 한다.
        // 위의 매개변수 textView는 작성(edit)이 종료(end)된 텍스트뷰이지만,
        // textView 에서 activeView 로 작성 상태가 '곧바로' 옮겨간 것이기 때문에
        // 키보드를 내리면(dismiss) 안된다.
        guard textView == activeView else { return true }
        
        activeView?.resignFirstResponder()
        activeView = nil

        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" { // 키보드의 'return' 키를 누르면 키보드 내리기
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
}
