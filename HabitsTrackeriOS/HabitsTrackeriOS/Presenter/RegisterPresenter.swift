//
//  RegisterPresenter.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 08.05.2023.
//

import Combine
import Foundation
import Firebase

class RegisterPresenter: ObservableObject {
    
    //MARK: - Properties

    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var error: String?
    @Published var user: User?
    
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
    
    func createUser() {
        guard let email = email,
              let password = password else { return }
        AuthManager.shared.registerUser(email: email, password: password)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.createRecord(for: user)
            }
            .store(in: &subscriptions)

    }
    
    // Добавление записи пользователя в базу данных
    func createRecord(for user: User) {
        DatabaseManager.shared.collectionUsersAdd(user: user)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print("Добавление записи пользователя в базу данных: \(state)")
            }
            .store(in: &subscriptions)

    }
    
}
