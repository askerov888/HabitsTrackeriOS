//
//  ProfileViewController.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 11.05.2023.
//

import Combine
import FirebaseAuth
import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var presenter = ProfilePresenter()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - Subviews

    private let avatarPlaceholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.backgroundColor = .lightGray
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .gray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let userName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Test Name"
        name.font = .systemFont(ofSize: 16, weight: .bold)
        name.textColor = .black
        return name
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupVC()
        setupSubviews()
        configureConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
//        handleAuthentication()
        presenter.retrieveUser()
        bindViews()
    }
    


}

//MARK: - Setups

private extension ProfileViewController {
    
    func setupVC() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                            style: .plain,
                            target: self,
                            action: #selector(didTapSignOut)),
            UIBarButtonItem(image: UIImage(systemName: "pencil"),
                            style: .plain,
                            target: self,
                            action: #selector(didTapEditor))
        ]
    }
    
    func setupSubviews() {
        view.addSubview(avatarPlaceholderImageView)
        view.addSubview(userName)
    }

    
    func bindViews() {
        presenter.$profileUser.sink { [weak self] user in
            guard let user = user else { return }
            DispatchQueue.main.async {
                self?.userName.text = user.name 
                self?.avatarPlaceholderImageView.sd_setImage(with: URL(string: user.avatarPath))
            }
        }
        .store(in: &subscriptions)
    }
    
}

//MARK: - Private func

private extension ProfileViewController {
    
//    func handleAuthentication() {
//        if Auth.auth().currentUser == nil {
//            let vc = RegisterViewController()
////            let vc = UINavigationController(rootViewController: RegisterViewController())
//            present(vc, animated: false)
//        }
//    }
    
    func completeUserOnboarding() {
        
    }
    
}

//MARK: - Action

private extension ProfileViewController {
    
    @objc func didTapSignOut() {
        try? Auth.auth().signOut()
        self.dismiss(animated: true)
//        handleAuthentication()
    }
    
    @objc func didTapEditor() {
        let vc = ProfileDataFormViewController()
        navigationController?.present(vc, animated: true)
    }
    
    
}

//MARK: - Configure constraints

private extension ProfileViewController {
    
    func configureConstraints() {
        let avatarPlaceholderImageViewConstraints = [
            avatarPlaceholderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarPlaceholderImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            avatarPlaceholderImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarPlaceholderImageView.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let userNameConstraints = [
            userName.topAnchor.constraint(equalTo: avatarPlaceholderImageView.bottomAnchor, constant: 20),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(avatarPlaceholderImageViewConstraints)
        NSLayoutConstraint.activate(userNameConstraints)
    }
    
}



