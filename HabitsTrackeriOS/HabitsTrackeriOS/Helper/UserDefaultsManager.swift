//
//  UserDefaultsManager.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 8/5/23.
//

import UIKit

class UserDefaultsManager {
	static let shared = UserDefaultsManager()
	private init () {}
	
	let defaults = UserDefaults.standard
	
	func saveHabit(person: Profile, habit: Habit) {
		var arrayHabbit = person.habits
		arrayHabbit?.append(habit)
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(arrayHabbit)
			
			defaults.set(data, forKey: person.id)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func loadHabit(person: Profile) -> [Habit] {
		var arrayhabits: [Habit] = []
		
		if let data = defaults.data(forKey: person.id) {
			do {
				let decoder = JSONDecoder()
				arrayhabits = try decoder.decode([Habit].self, from: data)
			} catch {
				print(error.localizedDescription)
			}
		}
		return arrayhabits
	}
}
