//
//  Profile.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 7/5/23.
//

import Foundation
import UIKit

class Profile {
	var name: String
	var image: UIImage
	var habits: [HabitProtocol]
	
	required init(name: String, image: UIImage, habits: [HabitProtocol]) {
		self.name = name
		self.image = image
		self.habits = habits
	}
}

