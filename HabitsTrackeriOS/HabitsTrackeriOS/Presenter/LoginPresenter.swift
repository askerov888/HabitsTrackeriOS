//
//  LoginPresenter.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 08.05.2023.
//

import Combine
import Foundation
import FirebaseAuth

class LoginPresenter: ObservableObject {
    
    //MARK: - Properties

    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var user: User?
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - Func
    
    // Проверка на валидность почты и пароля
    func validateAuthenticationForm() {
        guard let email = email,
              let password = password else {
            isAuthenticationFormValid = false
            return
        }
        isAuthenticationFormValid = isValidEmail(email) && password.count >= 8
    }
    
    // Проверка ввода правильных символов почты
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // 
    func loginUser() {
        guard let email = email,
              let password = password else { return }
        AuthManager.shared.loginUser(with: email, password: password)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)

    }
    
}
