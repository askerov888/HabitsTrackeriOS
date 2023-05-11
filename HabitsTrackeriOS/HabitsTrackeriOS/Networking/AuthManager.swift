//
//  AuthManager.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 11.05.2023.
//

import Combine
import Foundation
import Firebase
import FirebaseAuthCombineSwift

final class AuthManager {
    static let shared = AuthManager()
    
    func registerUser(email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
}
