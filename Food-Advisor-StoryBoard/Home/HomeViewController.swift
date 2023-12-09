//
//  HomeViewController.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 07.04.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let homeViewModel = HomeViewModel(networkManager: NetworkManager())
    private let searchController = UISearchController()
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet private weak var postsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        postsTableView.dataSource = self
        updateTableView()
    }
    
    private func configureUI() {
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        let logo = UIImage(named: logo)?.withRenderingMode(.alwaysOriginal)
        let search = UIImage(named: search)?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logo)
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: search, style: .plain, target: self, action: #selector(searchTapped))
        
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        postsTableView.addSubview(refreshControl)
    }
    
    private func updateTableView() {
        
        homeViewModel.getPosts { [weak self] in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.postsTableView.tableFooterView = nil
            }
        }
    }
    
    @objc private func handleRefreshControl() {
        
        updateTableView()
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func searchTapped() {
        
        navigationItem.searchController = searchController
    }
    
    private func createFooterSpinner() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
        return footerView
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
        
        guard let cell = cell else {
            return UITableViewCell()
        }
        
        cell.configure(post: post)
        
        homeViewModel.checkForLastCell(with: indexPath) {
            postsTableView.tableFooterView = createFooterSpinner()
            updateTableView()
        }
        
        return cell
    }
}
