//
//  Habbit.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 7/5/23.
//

import Foundation

protocol HabitProtocol: Codable {
	var title: String {get set}
	var description: String? {get set}
	var measure: [String: Int] {get set}
	var schedule: [Int: String] {get set}
	var periodStart: Calendar {get set}
	var periodFinish: Calendar {get set}
}

class Habit: HabitProtocol, Codable {
	var title: String
	var description: String?
	var measure: [String: Int]
	var schedule: [Int : String]
	var periodStart: Calendar
	var periodFinish: Calendar
	
	required init(title: String, description: String?, measure: [String: Int], schedule: [Int : String], periodStart: Calendar, periodFinish: Calendar) {
		self.title = title
		self.description = description
		self.measure = measure
		self.schedule = schedule
		self.periodStart = periodStart
		self.periodFinish = periodFinish
	}
}

struct DateChoise {
	static let choice = ["Day", "Week", "Month", "Year"]
}

