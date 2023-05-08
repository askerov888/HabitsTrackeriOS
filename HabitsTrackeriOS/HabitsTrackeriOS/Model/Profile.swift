//
//  Profile.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 7/5/23.
//

import Foundation
import UIKit

class Profile: Codable {
	var id: String
	var name: String
	var imageData: Data?
	var habits: [Habit]?
	var image: UIImage? {
		get {
			if let data = imageData {
				return UIImage(data: data)
			} else {
				return nil
			}
		}
		set {
			if let image = newValue {
				imageData = image.pngData()
			} else {
				imageData = nil
			}
		}
	 }
	
	required init(name: String, image: UIImage?, habits: [Habit]?) {
		self.id = UUID().uuidString
		self.name = name
		self.image = image
		self.habits = habits
	}
}
