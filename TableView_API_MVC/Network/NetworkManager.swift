//
//  NetworkManager.swift
//  HackerNews_MVVM
//
//  Created by Koushik Reddy Kambham on 9/5/25.
//

import Foundation

protocol Network {
    func getData(from serverUrl: String, closure: @escaping ([Post]) -> Void)
}

class NetworkManager: Network {
    static let shared = NetworkManager()

    func getData(from serverUrl: String, closure: @escaping ([Post]) -> Void) {
        guard let serverURL = URL(string: serverUrl) else {
            print("Server URL is invalid")
            closure([])
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: serverURL)) { data, response, error in
            
            if let error = error {
                print("Error fetching data: \(error)")
                closure([])
                return
            }
            
            guard let data = data else {
                print("No data returned from the server")
                closure([])
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                closure(posts)
            } catch {
                print("Error parsing JSON: \(error)")
                closure([])
            }
        }.resume()
    }
}
