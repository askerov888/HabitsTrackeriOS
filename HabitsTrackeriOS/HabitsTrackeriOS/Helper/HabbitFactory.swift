//
//  HabbitFactory.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 7/5/23.
//

import Foundation

// MARK: Prepared Habbits

class Running: HabitProtocol {
	var title: String = "running"
	var description: String = """
Regular running or jogging offers many health benefits. Running can:
	- help to build strong bones, as it is a weight bearing exercise
	- strengthen muscles
	- improve cardiovascular fitness
	- burn plenty of kilojoules
	- help maintain a healthy weight.
"""
	var aim: [Int: String] = [5: "km"]
	var schedule: [Int : DateChoice] = [3: .week]
	var periodStart: Date
	var periodFinish: Date
	required init (periodStart: Date, periodFinish: Date) {
		self.periodStart = periodStart
		self.periodFinish = periodFinish
	}
}

class Walking: HabitProtocol {
	var title: String = "walking"
	var description: String = """
Walking for 30 minutes a day or more on most days of the week is a great way to improve or maintain your overall health.
If you can’t manage 30 minutes a day, remember even short walks more frequently can be beneficial.
Walking with others can turn exercise into an enjoyable social occasion.
"""
	var aim: [Int: String] = [20: "minutes"]
	var schedule: [Int : DateChoice] = [3: .week]
	var periodStart: Date
	var periodFinish: Date
	required init (periodStart: Date, periodFinish: Date) {
		self.periodStart = periodStart
		self.periodFinish = periodFinish
	}
}

class Yoga: HabitProtocol {
	var title: String = "yoga"
	var description: String = """
Yoga offers physical and mental health benefits for people of all ages. And, if you’re going through an illness, recovering from surgery or living with a chronic condition, yoga can become an integral part of your treatment and potentially hasten healing.
"""
	var aim: [Int: String] = [30: "minutes"]
	var schedule: [Int : DateChoice] = [7: .week]
	var periodStart: Date
	var periodFinish: Date
	required init (periodStart: Date, periodFinish: Date) {
		self.periodStart = periodStart
		self.periodFinish = periodFinish
	}
}


class Reading: HabitProtocol {
	var title: String = "reading"
	var description: String = """
Book coaches one’s imagination to think big. A constant fuel is required by our mind to develop knowledge and enrich our perspective, here the importance of reading comes into play. Reading is not just a leisure activity but can also be beneficial when it comes to clearing some of the globally recognized competitive examinations . Developing a reading habit can help you go a long way both personally as well as in acing many examinations.
"""
	var aim: [Int: String] = [20: "minutes"]
	var schedule: [Int : DateChoice] = [30: .mounth]
	var periodStart: Date
	var periodFinish: Date
	required init (periodStart: Date, periodFinish: Date) {
		self.periodStart = periodStart
		self.periodFinish = periodFinish
	}
}

class Drinking: HabitProtocol {
	var title: String = "drinking"
	var description: String = """
Getting enough water every day is important for your health. Drinking water can prevent dehydration, a condition that can cause unclear thinking, result in mood change, cause your body to overheat, and lead to constipation and kidney stones. Water has no calories, so it can also help with managing body weight and reducing calorie intake when substituted for drinks with calories, such as sweet tea or regular soda.
"""
	var aim: [Int: String] = [3: "litre"]
	var schedule: [Int : DateChoice] = [1: .day]
	var periodStart: Date
	var periodFinish: Date
	required init (periodStart: Date, periodFinish: Date) {
		self.periodStart = periodStart
		self.periodFinish = periodFinish
	}
}

enum listOfHabits {
	case running
	case walking
	case yoga
	case reading
}

// MARK: Factory

class HabitFactory {
	static let shared = HabitFactory()
	private init() {}
	
	func getFromHabitList(title: listOfHabits, start: Date, finish: Date) -> HabitProtocol {
		switch title {
		case .running:
			return Running(periodStart: start, periodFinish: finish)
		case .walking:
			return Walking(periodStart: start, periodFinish: finish)
		case .reading:
			return Reading(periodStart: start, periodFinish: finish)
		case .yoga:
			return Yoga(periodStart: start, periodFinish: finish)
		}
	}
}




				




