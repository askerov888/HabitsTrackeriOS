//
//  EditHabitPresenter.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 9/5/23.
//

import Foundation
import UIKit

class EditHabitPresenter {
	weak var vc: EditHabitViewController!
	
	func updateHabit(habit: Habit) {
//		UserDefaultsManager.shared.saveHabit(person: TestData.testProfile, habit: habit)
	}
	
	func showAlertError(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let close = UIAlertAction(title: "Ok", style: .default, handler: { _ in
			alert.dismiss(animated: true, completion: nil)
		})
		alert.addAction(close)
		vc.present(alert, animated: true, completion: nil)
	}
	
	func showAlertSave() {
		let alert = UIAlertController(title: "Successfully saved", message: nil, preferredStyle: .alert)
		let close = UIAlertAction(title: "Ok", style: .default, handler: { _ in
			alert.dismiss(animated: true, completion: nil)
			self.vc.navigationController?.popViewController(animated: true)
		})
		alert.addAction(close)
		vc.present(alert, animated: true, completion: nil)
	}
}
