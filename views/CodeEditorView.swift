import SwiftUI
import Highlightr

struct CodeEditorView: NSViewRepresentable {
    @Binding var code: String
    let language: String
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.backgroundColor = .textBackgroundColor
        textView.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        let highlightr = Highlightr()!
        highlightr.setTheme(to: "darkula")
        nsView.textStorage?.setAttributedString(
            highlightr.highlight(code, as: language) ?? NSAttributedString(string: code)
        )
    }
}