//
//  ContentView.swift
//  iOS-generate-invoice
// 
//  Sample implementation
//

import SwiftUI
import PDFKit

struct ContentView: View {
    @State private var pdfData: Data? = nil
    @State private var showingShareSheet = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.createPDF()
                self.showingShareSheet = true
            }) {
                Text("Generate PDF and Share")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $showingShareSheet, content: {
                if let pdfData = self.pdfData {
                    ShareSheet(activityItems: [pdfData])
                }
            })
        }
    }
    
    func createPDF() {
        let pdfMetaData = [
            kCGPDFContextCreator: "My App",
            kCGPDFContextAuthor: "My Name",
            kCGPDFContextTitle: "Hello World PDF"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        pdfData = renderer.pdfData { (context) in
            context.beginPage()
            
            let text = "Hello World"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 72),
                .foregroundColor: UIColor.black
            ]
            let textRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
            text.draw(in: textRect, withAttributes: attributes)
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
