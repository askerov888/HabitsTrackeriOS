//
//  ProfileDataFormPresenter.swift
//  HabitsTrackeriOS
//
//  Created by Dmitryi Velko on 11.05.2023.
//

import Foundation
import Combine
import UIKit
import FirebaseAuth
import FirebaseStorage

final class ProfileDataFormPresenter: ObservableObject {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var userName: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    @Published var error: String = ""
    @Published var isOnboardingFinished: Bool = false
    
    func validateUserProfileForm() {
        guard let userName = userName, userName.count > 2,
              imageData != nil else {
            isFormValid = false
            return
        }
        isFormValid = true
    }
    
    func uploadAvatar() {
        let randomID = UUID().uuidString
        guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        StorageManager.shared.uploadProfilePhoto(with: randomID, image: imageData, metaData: metaData)
            .flatMap { metaData in
                StorageManager.shared.getDownloadURL(for: metaData.path)
            }
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("uploadProfilePhotoError = " + error.localizedDescription)
                    self?.error = error.localizedDescription
                case .finished:
                    self?.updateUserData()
                }
            } receiveValue: { [weak self] url in
                self?.avatarPath = url.absoluteString
            }
            .store(in: &subscriptions)

    }
    
    private func updateUserData() {
        guard let userName,
              let avatarPath,
              let id = Auth.auth().currentUser?.uid else { return }
        print("Проверка ID = \(id)")
        
        let updateFields: [String: Any] = [
            "userName": userName,
            "avatarPath": avatarPath,
            "isUserOnboarded": true
        ]
        
        DatabaseManager.shared.collectionUsers(updateFields: updateFields, for: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    print("updateFieldsError = " + error.localizedDescription)
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] onboardingState in
                self?.isOnboardingFinished = onboardingState
            }
            .store(in: &subscriptions)

    }
    
    
}

