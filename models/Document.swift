struct Document: Identifiable {
    let id = UUID()
    var content: String
    var fileType: FileType = .txt
}