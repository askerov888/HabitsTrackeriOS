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
	var aim: [Int: String] {get set}
	var schedule: [Int: DateChoice] {get set}
	var periodStart: DateComponents {get set}
	var periodFinish: DateComponents {get set}
}

class Habit: HabitProtocol, Codable {
	var title: String
	var description: String?
	var aim: [Int: String]
	var schedule: [Int : DateChoice]
	var periodStart: DateComponents
	var periodFinish: DateComponents
	
	required init(title: String, description: String?, aim: [Int: String], schedule: [Int : DateChoice], periodStart: DateComponents, periodFinish: DateComponents) {
		self.title = title
		self.description = description
		self.aim = aim
		self.schedule = schedule
		self.periodStart = periodStart
		self.periodFinish = periodFinish
	}
}

enum DateChoice: Codable {
	case day
	case week
	case mounth
}
