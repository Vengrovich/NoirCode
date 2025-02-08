import SwiftUI

class AppCoordinator: ObservableObject {
    // MARK: - Properties
    @Published var currentView: AnyView?
    
    // MARK: - Initialization
    init() {
        // Загружаем начальный экран
        showMainEditor()
    }
    
    // MARK: - Navigation Methods
    
    /// Показывает главный редактор
    func showMainEditor() {
        Logger.shared.log("Загрузка главного экрана редактора")
        let viewModel = EditorViewModel()
        let contentView = ContentView(viewModel: viewModel)
            .environmentObject(self) // Передаем координатор в окружение
        currentView = AnyView(contentView)
    }
    
    /// Показывает экран создания нового файла
    func showNewFileTypeView(isPresented: Binding<Bool>, viewModel: EditorViewModel) {
        let newFileView = NewFileTypeView(isPresented: isPresented, viewModel: viewModel)
        currentView = AnyView(newFileView)
    }
    
    /// Показывает предупреждение перед закрытием несохраненного файла
    func showUnsavedChangesAlert(onConfirm: @escaping () -> Void) {
        let alert = NSAlert()
        alert.messageText = "У вас есть несохраненные изменения."
        alert.informativeText = "Вы хотите сохранить файл перед закрытием?"
        alert.addButton(withTitle: "Сохранить")
        alert.addButton(withTitle: "Не сохранять")
        alert.addButton(withTitle: "Отмена")
        
        let response = alert.runModal()
        switch response {
        case .alertFirstButtonReturn: // Сохранить
            onConfirm()
        case .alertSecondButtonReturn: // Не сохранять
            break
        default: // Отмена
            return
        }
    }
}


