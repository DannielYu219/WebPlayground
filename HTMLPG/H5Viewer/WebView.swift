//
//  WebView.swift
//  HTMLPG
//
//  Created by Daniel www on 2025/1/29.
//
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

