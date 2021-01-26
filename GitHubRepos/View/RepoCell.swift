//
//  RepoCell.swift
//  GitHubRepos
//
//  Created by Giorgi on 1/26/21.
//

import UIKit

class RepoCell: UITableViewCell {
    
    //MARK: - Properties
    
    var repo: Repo? {
        didSet {
            configure()
        }
    }
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "folder.fill")
        view.setDimensions(height: 40, width: 40)
        view.layer.cornerRadius = 40 / 2
        
        return view
    }()
    
    private let repoNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.text = "RepoName"
        
        return view
    }()
    
    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(iconImageView)
        iconImageView.centerY(inView: self)
        iconImageView.anchor(left: leftAnchor, paddingLeft: 20)
        
        addSubview(repoNameLabel)
        repoNameLabel.centerY(inView: iconImageView)
        repoNameLabel.anchor(left: iconImageView.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let repo = repo else {return}
        repoNameLabel.text = repo.name
        
    }
}
