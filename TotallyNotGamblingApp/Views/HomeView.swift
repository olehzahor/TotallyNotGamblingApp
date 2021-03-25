//
//  WebView.swift
//  TotallyNotGamblingApp
//
//  Created by jjurlits on 3/24/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = WebViewViewModel()
    
    var body: some View {
        if viewModel.shouldNavigateToNextView {
            SlotsView()
        } else {
            ZStack {
                Background()
                
                if viewModel.isLoading {
                    LoadingView()
                }
                
                WebView(url: Constants.affiliateUrl, viewModel: viewModel)
                    .opacity(viewModel.shouldShowWebView ? 1 : 0)
            }
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView().padding(.top, 16)
            Text("Loading...").padding()
        }.background(Color("controls-background"))
        .cornerRadius(16)
    }
}

struct Background: View {
    var body: some View {
        Color("background")
            .edgesIgnoringSafeArea(.all)
    }
}
