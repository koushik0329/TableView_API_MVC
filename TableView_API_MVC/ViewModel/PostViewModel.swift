//
//  PostViewModel.swift
//  TableView_API_MVC
//
//  Created by Koushik Reddy Kambham on 9/5/25.
//

import Foundation

protocol PostViewModelProtocol {
    var postList : [Post] { get }
    func getDataFromServer(closure: @escaping (() -> Void))
    func numberOfRows() -> Int
    func getPost(at index: Int) -> Post
}

class PostViewModel : PostViewModelProtocol{
    
    var postList : [Post] = []
    
    var networkManager = NetworkManager.shared
    
    func getDataFromServer(closure: @escaping (() -> Void)) {
        networkManager.getData(from: Server.endPoint.rawValue) { [weak self] fetchedPosts in
            self?.postList = fetchedPosts
            closure()
        }
    }
    
    func numberOfRows() -> Int {
        return postList.count
    }
    
    func getPost(at index: Int) -> Post {
        return postList[index]
    }
}
