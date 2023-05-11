//
//  ProfileViewController.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 11.05.2023.
//

import Combine
import FirebaseAuth
import UIKit
import PhotosUI

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
        addGesture()
        configureConstraints()
        bindViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false 
        handleAuthentication()
        presenter.retrieveUser()
    }
    


}

//MARK: - Setups

private extension ProfileViewController {
    
    func setupVC() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapSignOut))
    }
    
    func setupSubviews() {
        view.addSubview(avatarPlaceholderImageView)
        view.addSubview(userName)
    }
    
    func addGesture() {
        avatarPlaceholderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToPhoto)))

    }
    
    func bindViews() {
        presenter.$profileUser.sink { [weak self] user in
            guard let user = user else { return }
            DispatchQueue.main.async {
                self?.userName.text = user.id
            }
        }
        .store(in: &subscriptions)
    }
    
}

//MARK: - Private func

private extension ProfileViewController {
    
    func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = RegisterViewController()
//            let vc = UINavigationController(rootViewController: RegisterViewController())
            present(vc, animated: false)
        }
    }
    
    func completeUserOnboarding() {
        
    }
    
}

//MARK: - Action

private extension ProfileViewController {
    
    @objc func didTapToPhoto() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
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

//MARK: - PHPickerViewControllerDelegate

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarPlaceholderImageView.image = image
                    }
                }
            }
        }
    }
    
    
}

