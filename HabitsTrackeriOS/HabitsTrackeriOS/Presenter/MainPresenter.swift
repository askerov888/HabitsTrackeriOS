//
//  MainPresenter.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 8/5/23.
//

import UIKit

class MainPresenter {
	weak var vc: MainViewController!
	var habits: [Habit] = []
	
	func load() {
		habits = UserDefaultsManager.shared.loadHabit(person: TestData.testProfile)
		
		if habits.isEmpty {
			habits = TestData.shared.createTestHabits()
		}
	}
	
	func deleteHabit(index: IndexPath) {
		habits.remove(at: index.section)
	}
	
	func signInAction() {
		let register = RegisterViewController()
		vc.present(register, animated: true, completion: nil)
	}
	
	func createHabitAction() {
		let createHabitVC = CreateHabitViewController()
		vc.present(createHabitVC, animated: true, completion: nil)
	}
}
