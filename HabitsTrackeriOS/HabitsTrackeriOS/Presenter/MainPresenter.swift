//
//  MainPresenter.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 8/5/23.
//

import UIKit

class MainPresenter {
	weak var vc: MainViewController!
	var person = Profile(name: "adi", image: nil, habits: nil)
	var habits: [Habit] = []
	
	func load() {
		let start = DateComponents(year: 2023, month: 1, day: 1, hour: 1, minute: 1)
		let finish = DateComponents(year: 2024, month: 1, day: 1, hour: 1, minute: 1)
//		habits = UserDefaultsManager.shared.loadHabit(person: person)
		let habit = HabitFactory.shared.getFromHabitList(title: .running, start: start, finish: finish)
		let habit2 = HabitFactory.shared.getFromHabitList(title: .drinking, start: start, finish: finish)
		habits = [habit, habit2]
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
