//
//  CustomTextEditor.swift
//  introspec
//
//  Created by Baba Yaga on 19/11/24.
//

import Foundation
import SwiftUI

struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isSelectable = true
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.backgroundColor = UIColor.clear
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        applyFormatting(to: uiView)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func applyFormatting(to textView: UITextView) {
        let text = textView.text ?? ""
        let attributedText = NSMutableAttributedString(string: text)

        let lines = text.components(separatedBy: "\n")
        for (index, line) in lines.enumerated() {
            let range = (text as NSString).range(of: line)
            if index == 0 {
                    attributedText.addAttribute(
                        .font,
                        value: UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize),
                        range: range
                    )
                } else {
                    attributedText.addAttributes([
                                    .font: UIFont.preferredFont(forTextStyle: .body),
                                    .foregroundColor: UIColor(named: "primaryText") ?? UIColor.black
                                ], range: range)
                }
        }

        textView.attributedText = attributedText
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor

        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

extension UITextView {
    func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(resignFirstResponder))
        toolbar.items = [doneButton]
        self.inputAccessoryView = toolbar
    }
}
