//
//  WebViewController.swift
//  TotallyNotGamblingApp
//
//  Created by jjurlits on 3/24/21.
//

import Foundation
import SwiftUI
import WebKit
import FBSDKCoreKit

struct CustomFBAnalyticsEvents {
    static let passedTrough = AppEvents.Name(rawValue: "User has passed to the app")
    static let webviewLoaded = AppEvents.Name(rawValue: "Webview has shown to the user")
}

class WebViewViewModel: ObservableObject {
    @Published private(set) var shouldShowWebView = false
    @Published private(set) var shouldNavigateToNextView = false
    @Published private(set) var isLoading = true
    
    func loadingStarted() {
        isLoading = true
    }
    
    func safeLinkLoaded() {
        isLoading = false
        shouldNavigateToNextView = true
        AppEvents.logEvent(CustomFBAnalyticsEvents.passedTrough)
    }
    
    func affiliateLinkLoaded() {
        isLoading = false
        shouldShowWebView = true
        AppEvents.logEvent(CustomFBAnalyticsEvents.webviewLoaded)
    }
    
    func failedToLoadLink() {
        isLoading = false
        shouldNavigateToNextView = true
    }
}

struct WebView {
    var url: String
    var viewModel: WebViewViewModel?
}

extension WebView: UIViewRepresentable {
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: self.url) else { return }
        
        let request = URLRequest(
            url: url, timeoutInterval: TimeInterval(Constants.timeout))
        
        uiView.load(request)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.viewModel?.loadingStarted()
            let url = webView.url
            let isSafeLinkLoaded = Constants.safeUrls.contains { url?.absoluteString.contains($0) ?? false }
            if isSafeLinkLoaded {
                parent.viewModel?.safeLinkLoaded()
            } else {
                parent.viewModel?.affiliateLinkLoaded()
            }
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.viewModel?.failedToLoadLink()
        }
    }
}

