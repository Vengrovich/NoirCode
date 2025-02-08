import Foundation
import SwiftUI
import AppKit

class EditorViewModel: ObservableObject {
    @Published var document = Document()
    @Published var showFileTypePicker = false
    
    func createNewDocument(ofType type: FileType) {
        document = Document(content: type.template, fileType: type)
    }
    
    func saveFile() {
    let panel = NSSavePanel()
    panel.allowedContentTypes = [document.fileType.utType]
    panel.nameFieldStringValue = "Untitled.\(document.fileType.rawValue)"
    
    panel.begin { response in
        guard response == .OK, let url = panel.url else {
            Logger.shared.log("Пользователь отменил сохранение файла", level: .warning)
            return
        }
        
        do {
            switch self.document.fileType {
            case .txt, .md:
                try self.document.content.write(to: url, atomically: true, encoding: .utf8)
                Logger.shared.log("Файл успешно сохранён: \(url.path)")
            case .rtf:
                let attributedString = NSAttributedString(string: self.document.content)
                try attributedString.data(from: .init(location: 0, length: attributedString.length),
                                        documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])
                    .write(to: url)
                Logger.shared.log("RTF файл успешно сохранён: \(url.path)")
            default:
                break
            }
        } catch {
            Logger.shared.logError(error, description: "Не удалось сохранить файл.")
        }
    }
}




