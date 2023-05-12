//
//  TestData.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 11/5/23.
//

import Foundation

struct TestData {
	static let shared = TestData()
	
//	static let testProfile = Profile(name: "testUser", image: nil, habits: nil)
	
	func createTestHabits() -> [Habit] {
		var habits = [Habit]()
		
		let start = Calendar.current
		let finish = Calendar.current
	
		let habit = HabitFactory.shared.getFromHabitList(title: .running, start: start, finish: finish)
		let habit2 = HabitFactory.shared.getFromHabitList(title: .drinking, start: start, finish: finish)
		habits = [habit, habit2]
		return habits
	}
}
