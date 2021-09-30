//
//  UploadRecipeKeyboardHandler.swift
//  Martini
//
//  Created by RONICK on 2021/09/26.
//

import UIKit

extension UploadRecipeViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardFrame: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // 스크롤 안쪽 아래에 키보드의 높이 만큼 여백 만들기
        // (스크롤 뷰 bottom은 safeArea 에 맞춰저 있어서 계산해줘야 함)
        scrollView.contentInset.bottom = keyboardFrame.height - view.safeAreaInsets.bottom + KEYBOARD_SPACER
//        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        // 스크롤 영역 내에서 activeBounds가 보이도록 하기
        if let activeBounds = self.activeBounds {
            self.scrollView.scrollRectToVisible(activeBounds, animated: true)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    // 빈 공간 더치시 키보드 내리기
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        
        guard activeView != nil else {
            return
        }
        
        activeView?.resignFirstResponder()
        activeView = nil
    }

}
