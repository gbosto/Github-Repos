//
//  UserProfileController.swift
//  GitHubRepos
//
//  Created by Giorgi on 1/26/21.
//

import UIKit

class UserProfileController: UIViewController {
    
    //MARK: - Properties

    private lazy var userProfileView = UserProfileView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField()
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        view.leftView = spacer
        view.leftViewMode = .always


        view.layer.cornerRadius = 10
        view.enablesReturnKeyAutomatically = true
        view.returnKeyType = .search
        view.borderStyle = .roundedRect
        view.textColor = .black
        view.keyboardAppearance = .dark
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.setDimensions(height: 40, width: 300)
        
        view.attributedPlaceholder = NSAttributedString(string: "Enter username..",
                                                   attributes: [.foregroundColor : UIColor.lightGray])
        
        return view
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.text = .none
    }
    
    //MARK: - API
    
    func fetchImage(url: String, completion: @escaping(UIImage)-> Void) {

        Service.fetchImageData(forImageUrl: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {return}
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Helpers
    
    func dismissKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self,
                                                                  action: #selector(handleDismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
   
    func configureUi(){
        view.backgroundColor = .white
        view.addSubview(userProfileView)
        userProfileView.centerX(inView: view)
        userProfileView.anchor(top: view.topAnchor, paddingTop: 50)
        
        view.addSubview(searchTextField)
        searchTextField.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                paddingLeft: 20, paddingBottom: 100,  paddingRight: 20)
        
        searchTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Actions
    
    @objc func handleDismissKeyboard(){
       view.endEditing(true)
   }
    
    @objc func keyboardWillShow(){
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 200
        }
    }
    
    @objc func keyboardWillHide(){
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

//MARK: - UISearchTextFieldDelegate

extension UserProfileController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let controller = ReposController()
        controller.delegate = self
        controller.username = textField.text
        textField.resignFirstResponder()
        
        navigationController?.pushViewController(controller, animated: true)
        return true
    }
}

//MARK: - ReposControllerDelegate

extension UserProfileController: ReposControllerDelegate {
    func controller(_ controller: ReposController, wantsToShowReposDetails repo: Repo) {
        userProfileView.repo = repo
        self.fetchImage(url: repo.user.imageUrl) { image in
            self.userProfileView.image = image
        }
        navigationController?.popViewController(animated: true)
    }
    
    func controllerWantsToSearch(_ controller: ReposController) {
        userProfileView.image = nil
        userProfileView.repo = nil
        navigationController?.popViewController(animated: true)
    }
}
