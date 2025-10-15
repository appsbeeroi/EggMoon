import SwiftUI
import WebKit

struct WebView: View {
    
    let url: URL
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Back") {
                    action()
                }
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .background(.black)
            
            Divider()
            
            WebViewRepresentable(url: url)
        }
    }
}

struct WebViewRepresentable: UIViewRepresentable {
    
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct MetricsResponse {
    let isOrganic: Bool
    let url: String
    let parameters: [String: String]
}

import SwiftUI
import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import UIKit
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport




class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMetrics(bundleID: String, salt: String, idfa: String?, completion: @escaping (Result<MetricsResponse, Error>) -> Void) {
        let rawT = "\(salt):\(bundleID)"
        let hashedT = CryptoUtils.md5Hex(rawT)
        
        var components = URLComponents(string: AppConstants.metricsBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "b", value: bundleID),
            URLQueryItem(name: "t", value: hashedT)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let isOrganic = json["is_organic"] as? Bool ?? false
                    guard let url = json["URL"] as? String else {
                        completion(.failure(NetworkError.invalidResponse))
                        return
                    }
                    
                    let parameters = json.filter { $0.key != "is_organic" && $0.key != "URL" }
                        .compactMapValues { $0 as? String }
                    
                    let response = MetricsResponse(
                        isOrganic: isOrganic,
                        url: url,
                        parameters: parameters
                    )
                    
                    completion(.success(response))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
