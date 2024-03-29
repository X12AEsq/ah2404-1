//
//  TextFieldWithFocus.swift
//  ah2404-1
//
//  Created by Morris Albers on 5/17/23.
//

import Foundation
import Combine
import SwiftUI

struct TextFieldWithFocus: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isFirstResponder: Bool
        var didBecomeFirstResponder = false

        var onCommit: () -> Void

        init(text: Binding<String>, isFirstResponder: Binding<Bool>, onCommit: @escaping () -> Void) {
            _text = text
            _isFirstResponder = isFirstResponder
            self.onCommit = onCommit
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            isFirstResponder = false
            didBecomeFirstResponder = false
            onCommit()
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            isFirstResponder = false
            didBecomeFirstResponder = false
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            isFirstResponder = true
        }
    }

    @Binding var text: String
    var placeholder: String
    @Binding var isFirstResponder: Bool
    var textAlignment: NSTextAlignment = .left
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var returnKeyType: UIReturnKeyType = .default
    var textContentType: UITextContentType?
    var textFieldBorderStyle: UITextField.BorderStyle = .none
    var enablesReturnKeyAutomatically: Bool = false
    @State var frameRect: CGRect = .zero
    
    var onCommit: (() -> Void)?
    
    func setFrameRect(_ rect: CGRect) -> some View {
        self.frameRect = rect
            
        return self
    }

    func makeUIView(context: UIViewRepresentableContext<TextFieldWithFocus>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = NSLocalizedString(placeholder, comment: "")
        textField.textAlignment = textAlignment
        textField.isSecureTextEntry = isSecure
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.textContentType = textContentType
        textField.borderStyle = textFieldBorderStyle
        textField.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically

        return textField
    }

    func makeCoordinator() -> TextFieldWithFocus.Coordinator {
        return Coordinator(text: $text, isFirstResponder: $isFirstResponder, onCommit: {
            self.onCommit?()
        })
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldWithFocus>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

struct TextFieldWithFocus_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithFocus(text: .constant(""), placeholder: "placeholder", isFirstResponder: .constant(false))
    }
}

/*
TextFieldWithFocus(text: $title,
    placeholder: NSLocalizedString("summary", comment: ""), isFirstResponder: $titleFocused, onCommit: {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    self.titleFocused = false
})
 
 GeometryReader { geometry in
     HStack {
         TextFieldWithFocus(text: self.$newString, placeholder: "placeholder", isFirstResponder: self.$textHasFocus,
             onCommit: { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil,
             from: nil, for: nil)
             self.textHasFocus = false
         })
             .setFrameRect(geometry.frame(in: .global))
             .frame(height: 36)
             .border(Color.black, width: 1)
             .padding(.horizontal)
 ...
 }
*/
