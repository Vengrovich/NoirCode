// версия до обновления, если что проверить.
//import SwiftUI

//@main
//struct NoirCodeApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .preferredColorScheme(.dark)
//                .environment(\.font, Font.system(.body, design: .monospaced))
//        }
//        .windowStyle(.hiddenTitleBar)
//    }
//}

import SwiftUI

@main
struct NoirCodeApp: App {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            if let currentView = coordinator.currentView {
                currentView
                    .environmentObject(coordinator)
            } else {
                ProgressView("Загрузка...")
            }
        }
    }
}