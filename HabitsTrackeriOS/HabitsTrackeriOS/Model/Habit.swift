//
//  Habbit.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 7/5/23.
//

import Foundation

protocol HabitProtocol {
	var title: String {get set}
	var description: String {get set}
	var aim: [Int: String] {get set}
	var schedule: [Int: DateChoice] {get set}
	var periodStart: Date {get set}
	var periodFinish: Date {get set}
}

final class Habit: HabitProtocol {
	var title: String
	var description: String
	var aim: [Int: String]
	var schedule: [Int : DateChoice]
	var periodStart: Date
	var periodFinish: Date
	
	required init(title: String, description: String, aim: [Int: String], countDate: [Int : DateChoice], periodStart: Date, periodFinish: Date) {
		self.title = title
		self.description = description
		self.aim = aim
		self.schedule = countDate
		self.periodStart = periodStart
		self.periodFinish = periodFinish
	}
}

enum DateChoice {
	case day
	case week
	case mounth
}
