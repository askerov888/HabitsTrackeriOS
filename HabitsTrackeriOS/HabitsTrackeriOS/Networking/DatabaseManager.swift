//
//  DatabaseManager.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 11.05.2023.
//

import Combine
import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    //MARK: - Properties
    
    private let db = Firestore.firestore()
    private let userPath = "users"

    //MARK: - Func

    // добавить юзера
    func collectionUsersAdd(user: User) -> AnyPublisher<Bool, Error> {
        let habitsTrackerUser = Profile(from: user)
        return db.collection(userPath).document(habitsTrackerUser.id).setData(from: habitsTrackerUser)
            .map { _ in return true }
            .eraseToAnyPublisher()
    }
    
    // длстать юзера
    func collectionUsersRetrieve(id: String) -> AnyPublisher<Profile, Error> {
        db.collection(userPath).document(id).getDocument()
            .tryMap { try $0.data(as: Profile.self) }
            .eraseToAnyPublisher()
    }
    
    // обновить инфу юзера
    func collectionUsers(updateFields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
        db.collection(userPath).document(id).updateData(updateFields)
            .map { _ in true }
            .eraseToAnyPublisher()
    }
    
}
