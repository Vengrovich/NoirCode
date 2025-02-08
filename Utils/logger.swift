import Foundation
import os.log

final class Logger {
    // MARK: - Singleton
    static let shared = Logger()
    private init() {}
    
    // MARK: - Properties
    private let logFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("NoirCodeLogs.txt")
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    // MARK: - Logging Methods
    
    /// Логирует сообщение в консоль и файл
    func log(_ message: String, level: LogLevel = .info) {
        let timestamp = dateFormatter.string(from: Date())
        let logMessage = "[\(timestamp)] [\(level.rawValue.uppercased())] \(message)"
        
        // Логирование в консоль
        os_log("%{public}@", log: .default, type: level.osLogType, logMessage)
        
        // Логирование в файл
        writeToFile(logMessage)
    }
    
    /// Логирует ошибку и показывает её пользователю
    func logError(_ error: Error, description: String? = nil, showToUser: Bool = true) {
        let errorMessage = "Ошибка: \(error.localizedDescription). \(description ?? "")"
        log(errorMessage, level: .error)
        
        if showToUser {
            DispatchQueue.main.async {
                self.showAlert(title: "Ошибка", message: errorMessage)
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Записывает сообщение в файл
    private func writeToFile(_ message: String) {
        guard let data = (message + "\n").data(using: .utf8) else { return }
        
        if FileManager.default.fileExists(atPath: logFileURL.path) {
            if let fileHandle = try? FileHandle(forWritingTo: logFileURL) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        } else {
            try? data.write(to: logFileURL, options: .atomic)
        }
    }
    
    /// Показывает алерт пользователю
    private func showAlert(title: String, message: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - LogLevel Enum
enum LogLevel: String {
    case info, warning, error
    
    var osLogType: OSLogType {
        switch self {
        case .info: return .info
        case .warning: return .default
        case .error: return .error
        }
    }
}