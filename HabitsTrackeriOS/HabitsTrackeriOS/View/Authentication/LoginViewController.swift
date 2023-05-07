//
//  LoginViewController.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 07.05.2023.
//

import UIKit

final class LoginViewController: UIViewController {

    //MARK: - Subviews
    
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log in"
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
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

}

//MARK: - Setups

private extension LoginViewController {
    
    func setupVC() {
        view.backgroundColor = .systemBackground
    }
    
    func setupSubviews() {
        view.addSubview(loginTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    func addGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
    }
    
    func bindViews() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
    }
    
}

//MARK: - Action

private extension LoginViewController {
    
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    
    @objc func didTapToDismiss() {
        view.endEditing(true)
    }
    
    @objc func didTapLoginButton() {
        
    }
    
    @objc func didChangeFirsNameField() {
        
    }
    
    @objc func didChangeLastNameField() {
        
    }
    
    @objc func didChangeEmailField() {
        
    }
    
    @objc func didChangePasswordField() {
        
    }
    
    @objc func didTapLogIn() {
        
    }
    
}

//MARK: - Constants

private extension LoginViewController {
    typealias C = Constants
    
    enum Constants {
        static let loginTextFieldsHeight: CGFloat = 30
        static let loginTextFieldsWidth: CGFloat = 289
        static let loginButtonHeight: CGFloat = 50
        static let loginButtonWidth: CGFloat = 289
        static let cornerRadiusTextFields: CGFloat = 15
        static let cornerRadiusRegisterButton: CGFloat = 25
    }
    
}


//MARK: - Configure constraints

private extension LoginViewController {
    
    func configureConstraints() {
        let registerTitleLabelConstraints = [
            loginTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ]
        
        let emailTextFieldConstraints = [
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 35),
            emailTextField.heightAnchor.constraint(equalToConstant: C.loginTextFieldsHeight),
            emailTextField.widthAnchor.constraint(equalToConstant: C.loginTextFieldsWidth)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
            passwordTextField.heightAnchor.constraint(equalToConstant: C.loginTextFieldsHeight),
            passwordTextField.widthAnchor.constraint(equalToConstant: C.loginTextFieldsWidth)
        ]
        
        let registerButtonConstraints = [
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            loginButton.heightAnchor.constraint(equalToConstant: C.loginButtonHeight),
            loginButton.widthAnchor.constraint(equalToConstant: C.loginButtonWidth)
        ]
        
        NSLayoutConstraint.activate(registerTitleLabelConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)
    }
    
}




