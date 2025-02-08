import UniformTypeIdentifiers

enum FileType: String, CaseIterable {
    case txt, rtf, md, docx, pdf
    
    var utType: UTType {
        switch self {
        case .txt: return .plainText
        case .rtf: return .rtf
        case .md: return .markdownText
        case .docx: return .microsoftWord
        case .pdf: return .pdf
        }
    }
    
    var template: String {
        switch self {
        case .md: return "# Новый документ"
        default: return ""
        }
    }
}