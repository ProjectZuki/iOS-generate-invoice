//
//  ContentView.swift
//  iOS-generate-invoice
// 
//  Sample implementation
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
            Button("Generate PDF") {
                generatePDF()
            }
        }
    }
    
    func generatePDF() {
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 200, height: 100))
        let data = renderer.pdfData { ctx in
            ctx.beginPage()
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 24)
            ]
            let text = "Hello, World!"
            text.draw(at: CGPoint(x: 50, y: 50), withAttributes: attributes)
        }
        
        savePDF(data: data)
    }
    
    func savePDF(data: Data) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("hello_world.pdf")
        
        do {
            try data.write(to: fileURL)
            print("PDF saved:", fileURL)
        } catch {
            print("Error saving PDF:", error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
