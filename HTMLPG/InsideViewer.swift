//
//  InsideViewer.swift
//  WebPlayground
//
//  Created by Daniel www on 2025/2/3.
//
import SwiftUI
import WebKit

struct HTMLView: View {
    let htmlFileName: String // 例如 "index.html"
    
    var body: some View {
        WebView(htmlString: htmlFileName)
            .edgesIgnoringSafeArea(.all)
    }
}

struct LocalWebView: UIViewRepresentable {
    let htmlFileName: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 加载本地 HTML 文件
        if let htmlURL = Bundle.main.url(forResource: htmlFileName, withExtension: nil) {
            let request = URLRequest(url: htmlURL)
            uiView.load(request)
        }
    }
}

