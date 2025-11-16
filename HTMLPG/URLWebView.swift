//
//  URLWebView.swift
//  WebPlayground
//
//  Created by Daniel www on 2025/2/10.
//
import SwiftUI
import WebKit

struct URLWebView: UIViewRepresentable {
    let url: URL
    
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
        
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true
        config.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: URLWebView

        init(_ parent: URLWebView) {
            self.parent = parent
        }
    }
}
