//
//  LoginPresenter.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 08.05.2023.
//

import Combine
import Foundation

class LoginPresenter: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    
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
    
}
