//
//  RegisterViewController.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 06.05.2023.
//

import Combine
import UIKit

final class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    
    private var presenter = RegisterPresenter()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - Subviews
    
    private let registerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Register"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = C.cornerRadiusTextFields
        textField.backgroundColor = .systemGray5
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium)]
        )
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = C.cornerRadiusTextFields
        textField.backgroundColor = .systemGray5
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium)]
        )
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let isThereAccountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "already have an account?"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.tintColor = .systemGray
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        setupSubviews()
        addGesture()
        bindViews()
        configureConstraints()
        
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		dismiss(animated: true, completion: nil)
	}

}

//MARK: - Setups

private extension RegisterViewController {
    
    func setupVC() {
        view.backgroundColor = .systemBackground
    }

    func setupSubviews() {
        view.addSubview(registerTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(isThereAccountTitleLabel)
        view.addSubview(loginButton)
    }
    
    func addGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
    }
    
    func bindViews() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        presenter.$isAuthenticationFormValid.sink { [weak self] validState in
            self?.registerButton.isEnabled = validState
        }
        .store(in: &subscriptions)
        
        presenter.$user.sink { [weak self] user in
            print(user)
        }
        
    }
    
}

//MARK: - Action

private extension RegisterViewController {
    
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    
    @objc func didTapToDismiss() {
        view.endEditing(true)
    }
    
    @objc func didChangeEmailField() {
        presenter.email = emailTextField.text
        presenter.validateAuthenticationForm()
    }
    
    @objc func didChangePasswordField() {
        presenter.password = passwordTextField.text
        presenter.validateAuthenticationForm()
    }
    
    @objc func didTapRegister() {
        presenter.createUser()
    }
    
    @objc func didTapLoginButton() {
        let vc = LoginViewController()
        self.present(vc, animated: true)
    }
    
}

//MARK: - Constants

private extension RegisterViewController {
    typealias C = Constants
    
    enum Constants {
        static let registerTextFieldsHeight: CGFloat = 30
        static let registerTextFieldsWidth: CGFloat = 289
        static let registerButtonHeight: CGFloat = 50
        static let registerButtonWidth: CGFloat = 289
        static let cornerRadiusTextFields: CGFloat = 15
        static let cornerRadiusRegisterButton: CGFloat = 25
    }
    
}


//MARK: - Configure constraints

private extension RegisterViewController {
    
    func configureConstraints() {
        let registerTitleLabelConstraints = [
            registerTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ]
        
        let emailTextFieldConstraints = [
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: registerTitleLabel.bottomAnchor, constant: 35),
            emailTextField.heightAnchor.constraint(equalToConstant: C.registerTextFieldsHeight),
            emailTextField.widthAnchor.constraint(equalToConstant: C.registerTextFieldsWidth)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
            passwordTextField.heightAnchor.constraint(equalToConstant: C.registerTextFieldsHeight),
            passwordTextField.widthAnchor.constraint(equalToConstant: C.registerTextFieldsWidth)
        ]
        
        let registerButtonConstraints = [
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            registerButton.heightAnchor.constraint(equalToConstant: C.registerButtonHeight),
            registerButton.widthAnchor.constraint(equalToConstant: C.registerButtonWidth)
        ]
        
        let isThereAccountTitleLabelConstraints = [
            isThereAccountTitleLabel.leadingAnchor.constraint(equalTo: registerButton.leadingAnchor),
            isThereAccountTitleLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 15)
        ]

        let loginButtonConstraints = [
            loginButton.leadingAnchor.constraint(equalTo: isThereAccountTitleLabel.trailingAnchor, constant: 5),
            loginButton.centerYAnchor.constraint(equalTo: isThereAccountTitleLabel.centerYAnchor)
        ]

        
        NSLayoutConstraint.activate(registerTitleLabelConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)
        NSLayoutConstraint.activate(isThereAccountTitleLabelConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
    }
    
}



