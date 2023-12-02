//
//  HomeViewController.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 07.04.23.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeViewModel = HomeViewModel()
    private let searchController = UISearchController()
    @IBOutlet private weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: logo)?.withRenderingMode(.alwaysOriginal)
        let search = UIImage(named: search)?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logo)
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: search, style: .plain, target: self, action: #selector(searchTapped))
        
        postsTableView.delegate = self
        postsTableView.dataSource = self

        homeViewModel.getPosts { [weak self] data in
            self?.homeViewModel.posts = data.posts
            DispatchQueue.main.async {
                self?.postsTableView.reloadData()
            }
        }
    }
    @objc func searchTapped() {
        navigationItem.searchController = searchController
    }
}
// MARK: - Delegate
extension HomeViewController: UITableViewDelegate {}
// MARK: - Data Source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = homeViewModel.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: postsCellIdentifier, for: indexPath) as? PostCell
        cell?.configure(post: post)
        return cell ?? UITableViewCell()
    }
}
