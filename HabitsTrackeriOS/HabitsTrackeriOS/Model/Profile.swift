//
//  Profile.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 7/5/23.
//

import Firebase
import UIKit

struct Profile: Codable {
	let id: String
	var name: String = ""
    var avatarPath: String = ""
    var habits: [Habit]?
    var isUserOnboarded: Bool = false
//	var imageData: Data?
//	var image: UIImage? {
//		get {
//			if let data = imageData {
//				return UIImage(data: data)
//			} else {
//				return nil
//			}
//		}
//		set {
//			if let image = newValue {
//				imageData = image.pngData()
//			} else {
//				imageData = nil
//			}
//		}
//	 }
	
//	init(name: String, image: UIImage?, habits: [Habit]?) {
//		self.id = UUID().uuidString
//		self.name = name
//		self.image = image
//		self.habits = habits
//	}
    
    init(from user: User) {
        self.id = user.uid
    }
}
