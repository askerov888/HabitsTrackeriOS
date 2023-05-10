//
//  CreateHabitPresenter.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 9/5/23.
//

import Foundation
import UIKit

class CreateHabitPresenter {
	weak var vc: CreateHabitViewController!
	
	func changeReply() {
		print("hello")
		let data = ["Day", "Week", "Month", "Year"]
		var menuItems: [UIAction] = []
		
		for item in data {
			let action = UIAction(title: item) { action in
				self.vc?.replayDateButton.setTitle(item, for: .normal)
			}
			menuItems.append(action)
		}
		let menu = UIMenu(title: "", children: menuItems)
		vc?.replayDateButton.menu = menu
	}
}
