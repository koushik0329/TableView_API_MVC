//
//  PostsViewController.swift
//  TableView_API_MVC
//
//  Created by Koushik Reddy Kambham on 9/5/25.
//

import UIKit

class PostsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var postsLabel: UILabel!
    var postsTableView: UITableView!
    
    var postList : [Post] = []
    
    var networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        
        getDataFromServer { [weak self] in
            DispatchQueue.main.async {
                self?.postsTableView.reloadData()
            }
        }
    }
    
    func getDataFromServer(closure: @escaping (() -> Void)) {
        networkManager.getData(from: Server.endPoint.rawValue) { [weak self] fetchedPosts in
            self?.postList = fetchedPosts
            closure()
        }
    }
    
    func setupUI() {
        postsLabel = UILabel()
        postsLabel.text = "Posts"
        postsLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        postsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postsLabel)
        
        NSLayoutConstraint.activate([
            postsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            postsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupTableView() {
        postsTableView = UITableView()
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.translatesAutoresizingMaskIntoConstraints = false
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "PostCell")
        view.addSubview(postsTableView)
        
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 150
        
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: postsLabel.bottomAnchor, constant: 20),
            postsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: postList[indexPath.row])
        return cell
    }
}
