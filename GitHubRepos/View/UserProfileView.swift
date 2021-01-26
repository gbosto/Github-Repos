//
//  UserProfileView.swift
//  GitHubRepos
//
//  Created by Giorgi on 1/26/21.
//

import UIKit

class UserProfileView: UIView {
    //MARK: - Properties
    
    var repo: Repo? {
        didSet {
            configure()
        }
    }
    
    var image: UIImage? {
        didSet {
            setImage()
        }
    }
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.crop.circle.fill")
        view.tintColor = .lightGray
        view.setDimensions(height: 120, width: 120)
        view.layer.cornerRadius = 120 / 2
        view.clipsToBounds = true
        
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.text = "Username:"
        
        return view
    }()
    
    private let repoNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.text = "Repository's name:"

        return view
    }()
    
    private let privacyStatusLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.text = "Privacy Status:"
        
        return view
    }()
    
    private let repoIdLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.text = "Repository's ID:"
        
        return view
    }()
    
    private let userIdLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.text = "User ID:"
        
        return view
    }()
    
    private var usernameOutputLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        
        return view
    }()
    
    private let repoNameOutputLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        
        return view
    }()
    
    private let privacyStatusOutputLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        
        return view
    }()
    
    private let repoIdOutputLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        
        return view
    }()
    
    private let userIdOutputLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        
        return view
    }()
    
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        
        let usernameStack = UIStackView(arrangedSubviews: [usernameLabel, usernameOutputLabel])
        usernameStack.axis = .horizontal
        usernameStack.spacing = 30
        
        let repoNameStack = UIStackView(arrangedSubviews: [repoNameLabel, repoNameOutputLabel])
        repoNameStack.axis = .horizontal
        repoNameStack.spacing = 50
        
        let privacyStatusStack = UIStackView(arrangedSubviews: [privacyStatusLabel, privacyStatusOutputLabel])
        privacyStatusStack.axis = .horizontal
        privacyStatusStack.spacing = 50
        
        let userIdStack = UIStackView(arrangedSubviews: [userIdLabel, userIdOutputLabel])
        userIdStack.axis = .horizontal
        userIdStack.spacing = 50
        
        let repoIdStack = UIStackView(arrangedSubviews: [repoIdLabel, repoIdOutputLabel])
        repoIdStack.axis = .horizontal
        repoIdStack.spacing = 70
        
        let stack = UIStackView(arrangedSubviews: [usernameStack, userIdStack, repoIdStack, repoNameStack, privacyStatusStack] )
        stack.axis = .vertical
        stack.spacing = 18
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                     paddingTop: 50, paddingLeft: 12, paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func setImage() {
        if image == nil {
            profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        }
        guard let image = image else {return}
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.profileImageView.image = image
        }
    }
    
    func configure() {
        if repo == nil {
            usernameOutputLabel.text = ""
            userIdOutputLabel.text = ""
            repoIdOutputLabel.text = ""
            repoNameOutputLabel.text = ""
            privacyStatusOutputLabel.text = ""
        }
        
        guard let repo = repo else {return}
        usernameOutputLabel.text = repo.user.username
        userIdOutputLabel.text = String(repo.user.userId)
        repoIdOutputLabel.text = String(repo.id)
        repoNameOutputLabel.text = repo.name
        privacyStatusOutputLabel.text = repo.privacyStatus ? "Public" : "Private"
        
        
    }

}
