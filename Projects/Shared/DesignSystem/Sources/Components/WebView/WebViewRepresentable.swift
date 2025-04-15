//
//  WebViewRepresentable.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 9/25/24.
//
import SwiftUI
import WebKit

public struct WebViewRepresentable: UIViewRepresentable {
  var url: String
  
  public init(url: String) {
    self.url = url
  }
  
  public func makeUIView(context: Context) -> WKWebView {
    guard let url = URL(string: url) else {
      return WKWebView()
    }
    let webView = WKWebView()
    
    webView.load(URLRequest(url: url))
    
    return webView
  }
  
  public func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WebViewRepresentable>) {
    guard let url = URL(string: url) else { return }
    
    webView.load(URLRequest(url: url))
  }
}
