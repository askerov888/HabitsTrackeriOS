//
//  HabbitFactory.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 7/5/23.
//

import Foundation

// MARK: Prepared Habbits

func running(periodStart: Calendar, periodFinish: Calendar) -> Habit {
	let habit = Habit(title: "running",
		  description: """
Regular running or jogging offers many health benefits. Running can:
	- help to build strong bones, as it is a weight bearing exercise
	- strengthen muscles
	- improve cardiovascular fitness
	- burn plenty of kilojoules
	- help maintain a healthy weight.
""",
		  measure: ["km":5],
		  schedule: [3: "week"],
		  periodStart: periodStart,
		  periodFinish: periodFinish)
	return habit
}

func walking(periodStart: Calendar, periodFinish: Calendar) -> Habit {
	let habit = Habit(
	title: "walking",
	description: """
Walking for 30 minutes a day or more on most days of the week is a great way to improve or maintain your overall health.
If you can’t manage 30 minutes a day, remember even short walks more frequently can be beneficial.
Walking with others can turn exercise into an enjoyable social occasion.
""",
	measure: ["minutes":20],
	schedule: [3: "week"],
	periodStart: periodStart,
	periodFinish: periodFinish)
	return habit
}

func yoga(periodStart: Calendar, periodFinish: Calendar) -> Habit {
	let habit = Habit(
	title: "yoga",
	description: """
Yoga offers physical and mental health benefits for people of all ages. And, if you’re going through an illness, recovering from surgery or living with a chronic condition, yoga can become an integral part of your treatment and potentially hasten healing.
""",
	measure: ["minutes":30],
	schedule: [7: "week"],
	periodStart: periodStart,
	periodFinish: periodFinish)
	return habit
}

func reading(periodStart: Calendar, periodFinish: Calendar) -> Habit {
	let habit = Habit(
	title: "reading",
	description: """
Book coaches one’s imagination to think big. A constant fuel is required by our mind to develop knowledge and enrich our perspective, here the importance of reading comes into play. Reading is not just a leisure activity but can also be beneficial when it comes to clearing some of the globally recognized competitive examinations . Developing a reading habit can help you go a long way both personally as well as in acing many examinations.
""",
	measure: ["minutes":20],
	schedule: [30: "mounth"],
	periodStart: periodStart,
	periodFinish: periodFinish)
	return habit
}

func drinking(periodStart: Calendar, periodFinish: Calendar) -> Habit {
	let habit = Habit(
	title: "drinking",
	description: """
Getting enough water every day is important for your health. Drinking water can prevent dehydration, a condition that can cause unclear thinking, result in mood change, cause your body to overheat, and lead to constipation and kidney stones. Water has no calories, so it can also help with managing body weight and reducing calorie intake when substituted for drinks with calories, such as sweet tea or regular soda.
""",
	measure: ["litre":3],
	schedule: [1: "day"],
	periodStart: periodStart,
	periodFinish: periodFinish)
	return habit
}


enum listOfHabits {
	case running
	case walking
	case yoga
	case reading
	case drinking
}

// MARK: Factory

class HabitFactory {
	static let shared = HabitFactory()
	private init() {}
	
	func getFromHabitList(title: listOfHabits, start: Calendar, finish: Calendar) -> Habit {
		switch title {
		case .running:
			return running(periodStart: start, periodFinish: finish)
		case .walking:
			return walking(periodStart: start, periodFinish: finish)
		case .reading:
			return reading(periodStart: start, periodFinish: finish)
		case .yoga:
			return yoga(periodStart: start, periodFinish: finish)
		case .drinking:
			return drinking(periodStart: start, periodFinish: finish)
		}
		
	}
}




				




