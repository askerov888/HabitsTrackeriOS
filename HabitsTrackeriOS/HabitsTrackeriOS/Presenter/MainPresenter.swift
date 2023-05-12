//
//  MainPresenter.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 8/5/23.
//

import Firebase
import UIKit

class MainPresenter {
	weak var vc: MainViewController!
	var habits: [Habit] = []
	
	func load() {
//		habits = UserDefaultsManager.shared.loadHabit(person: TestData.testProfile)
//		
//		if habits.isEmpty {
//			habits = TestData.shared.createTestHabits()
//		}
	}
	
	func deleteHabit(index: IndexPath) {
		habits.remove(at: index.section)
	}
	
    func signInAction() {
        if Auth.auth().currentUser != nil {
            let profileVC = ProfileViewController()
            vc.navigationController?.pushViewController(profileVC, animated: true)
        } else {
            let register = RegisterViewController()
            vc.navigationController?.pushViewController(register, animated: true)
        }
        
//        let profileVC = ProfileViewController()
//        vc.navigationController?.pushViewController(profileVC, animated: true)

//		  let register = RegisterViewController()
//        vc.navigationController?.pushViewController(register, animated: true)
    }
    
	func createHabitAction() {
		let createHabitVC = CreateHabitViewController()
		vc.present(createHabitVC, animated: true, completion: nil)
	}
}
