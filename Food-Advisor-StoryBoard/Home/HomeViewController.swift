//
//  HomeViewController.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 07.04.23.
//

import UIKit

final class HomeViewController: UIViewController {
    private var homeViewModel = HomeViewModel()
    private let searchController = UISearchController()
    private let refreshControl = UIRefreshControl()
    @IBOutlet private weak var postsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        let logo = UIImage(named: logo)?.withRenderingMode(.alwaysOriginal)
        let search = UIImage(named: search)?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logo)
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: search, style: .plain, target: self, action: #selector(searchTapped))
        
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        postsTableView.addSubview(refreshControl)
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        updateTableView()
    }
    func updateTableView() {
        homeViewModel.getPosts { [weak self] in
            DispatchQueue.main.async {
                self?.postsTableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    @objc func handleRefreshControl() {
        updateTableView()
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    @objc func searchTapped() {
        navigationItem.searchController = searchController
    }
}
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
// MARK: - Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homeViewModel.posts.count - 2 {
            updateTableView()
        }
    }
}
