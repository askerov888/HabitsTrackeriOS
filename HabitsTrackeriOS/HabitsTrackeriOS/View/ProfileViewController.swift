//
//  ProfileViewController.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 11.05.2023.
//

import FirebaseAuth
import UIKit
import PhotosUI

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var presenter = ProfilePresenter()

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
        imageView.image = UIImage(named: "iconAvatar")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .gray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let userName: UILabel = {
        let name = UILabel()
        name.text = ""
        return name
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupVC()
        setupSubviews()
        addGesture()
        configureConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
    }
    


}

//MARK: - Setups

private extension ProfileViewController {
    
    func setupVC() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
    }
    
    func setupSubviews() {
        view.addSubview(avatarPlaceholderImageView)
        view.addSubview(userName)
    }
    
    func addGesture() {
        avatarPlaceholderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToPhoto)))

    }
    
}

//MARK: - Private func

private extension ProfileViewController {
    
    func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: RegisterViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
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
        
        NSLayoutConstraint.activate(avatarPlaceholderImageViewConstraints)
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

