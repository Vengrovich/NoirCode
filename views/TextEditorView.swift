import SwiftUI
import AppKit

struct TextEditorView: NSViewRepresentable {
    @Binding var text: String
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.backgroundColor = .textBackgroundColor
        textView.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.string = text
    }
}