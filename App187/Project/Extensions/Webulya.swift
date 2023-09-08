//
//  Webulya.swift
//  App187
//
//  Created by Вячеслав on 9/8/23.
//

import SwiftUI
import FirebaseRemoteConfig
import WebKit

struct WebSystem: View {
    
    @State var response: URL = URL(string: "https://")!

    var body: some View {

        ZStack{

            Color("bg")
                .ignoresSafeArea()

            if !response.absoluteString.isEmpty {
                
                WebPresenter(link: response)
            }
        }
        .ignoresSafeArea(.all)
        .onAppear {

            getFirebaseData(field: "url_link", dataType: .url) { result in
                
                let result = result as? URL ?? URL(string: "nil")!
                
                response = result
            }
        }
    }
}

struct WebPresenter: UIViewRepresentable {

    var link: URL?

    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {

        guard let link = link else {

            return
        }

        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
        webView.load(URLRequest(url: link))
    }
}

func getFirebaseData(field: String, dataType: DataType, completion: @escaping (Any) -> Void) {

    let config = RemoteConfig.remoteConfig()

    config.configSettings.minimumFetchInterval = 300
    config.fetchAndActivate{ _, _ in
        
        if dataType == .bool {
            
            completion(config.configValue(forKey: field).boolValue)
            
        } else if dataType == .url {
            
            guard let url_string = config.configValue(forKey: field).stringValue, let url = URL(string: url_string) else {

                return
            }
            
            completion(url)
        }
    }
}

enum DataType: CaseIterable {
    
    case bool, url
}
