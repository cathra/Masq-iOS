//
//  MASTextView.swift
//  masq
//
//  Created by 翁培钧 on 2019/7/28.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import SwiftUI

struct MASTextView: UIViewRepresentable {
    /// 文本改变
    var changeHandler:((String) -> Void)?
    
    func makeCoordinator() -> MASTextView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MASTextView>) -> UITextView {
        let tv = UITextView()
        tv.tintColor = .secondaryLabel
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.delegate = context.coordinator
        tv.returnKeyType = .default
        tv.becomeFirstResponder()
        return tv
    }
    
    func updateUIView(_ uiView: UITextView,
                      context: UIViewRepresentableContext<MASTextView>) {
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var masTextView: MASTextView
        
        private var textView: UITextView? = nil
        // 是否开始编辑
        private(set) var isBeginEditng = false
        
        
        init(_ textView: MASTextView) {
            self.masTextView = textView
        }
        
        // MARK: UITextView Delegate

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard let textView = textView else { return }

            textView.resignFirstResponder()
        }
        
        func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
            self.textView = textView
            return true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            // 每次退出时都清空
            textView.text = ""
        }
        
        func textViewDidChange(_ textView: UITextView) {
            masTextView.changeHandler?(textView.text)
        }
    }
}
