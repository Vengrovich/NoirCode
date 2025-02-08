import SwiftUI

struct NewFileTypeView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: EditorViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Создать новый файл")
                .font(.title3.bold())
            
            ForEach(FileType.allCases, id: \.self) { type in
                Button(action: {
                    viewModel.createNewDocument(ofType: type)
                    isPresented = false
                }) {
                    HStack {
                        Image(systemName: "doc")
                        Text(type.rawValue.uppercased())
                        Spacer()
                    }
                    .padding(10)
                    .background(Color(.controlBackgroundColor))
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .frame(width: 280)
    }
}