//
//  ReposController.swift
//  GitHubRepos
//
//  Created by Giorgi on 1/26/21.
//

import UIKit

protocol ReposControllerDelegate: class {
    func controller(_ controller: ReposController, wantsToShowReposDetails repo: Repo)
    func controllerWantsToSearch(_ controller: ReposController)
}

class ReposController: UITableViewController {
    
    //MARK: - Properties
    weak var delegate: ReposControllerDelegate?
    var username: String?
    
    private var repos = [Repo]()
    private let cellId = "RepoCell"
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        fetchData()
    }
    
    
    //MARK: - API
    
    func fetchData() {
        guard let username = self.username else {return}
        startLoading()
        Service.fetchData(username: username) { result in
            switch result {
            case .success(let repos) :
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.stopLoading()
                    self.repos = repos
                    self.tableView.reloadData()
            }
            case .failure(let error):
                self.showMessage(message: error.localizedDescription)
        }
    }
}
    //MARK: - Helpers
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.delegate?.controllerWantsToSearch(self)
        }
        
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func configureUi() {
        navigationItem.title = "Repositories"
        let image = UIImage(systemName: "magnifyingglass")
        let searchButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleSearchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 64
        tableView.register(RepoCell.self, forCellReuseIdentifier: cellId)
        
        
    }
    
    //MARK: - Actions
    
    @objc func handleSearchButtonTapped() {
        delegate?.controllerWantsToSearch(self)
    }

}

//MARK: - TableView DataSource

extension ReposController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoCell
        let repo = repos[indexPath.row]
        cell.repo = repo
        
        return cell
    }
}

//MARK: - TableView Delegate

extension ReposController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.row]
        delegate?.controller(self, wantsToShowReposDetails: repo)
    }
}
