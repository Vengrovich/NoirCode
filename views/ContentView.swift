import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = EditorViewModel()
    @State private var showNewFileDialog = false
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.document.fileType == .md || viewModel.document.fileType == .txt {
                    TextEditorView(text: $viewModel.document.content)
                } else {
                    CodeEditorView(code: $viewModel.document.content, 
                                 language: viewModel.document.fileType.rawValue)
                }
            }
            .onAppear {
                Logger.shared.log("Главный экран успешно загружен")
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("Новый") { showNewFileDialog.toggle() }
                        Button("Сохранить") { viewModel.saveFile() }
                    } label: {
                        Label("Файл", systemImage: "doc")
                    }
                }
            }
            .sheet(isPresented: $showNewFileDialog) {
                NewFileTypeView(isPresented: $showNewFileDialog, 
                              viewModel: viewModel)
            }
        }
    }
}
