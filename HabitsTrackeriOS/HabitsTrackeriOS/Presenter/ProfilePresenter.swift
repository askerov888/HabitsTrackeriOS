//
//  ProfilePresenter.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 11.05.2023.
//

import Combine
import Foundation
import FirebaseAuth

final class ProfilePresenter: ObservableObject {
    
    //MARK: - Properties

    @Published var profileUser: Profile?
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - Func

    func retrieveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsersRetrieve(id: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.profileUser = user
            }
            .store(in: &subscriptions)
    }
    

    
}
