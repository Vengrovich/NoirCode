import PDFKit

class PDFInfoPrintingAdapter: NSObject, NSPrintingProtocol {
    private let data: NSMutableData
    
    init(data: NSMutableData) {
        self.data = data
    }
    
    func pdfData() -> Data {
        return data as Data
    }
}