//
//  CreateHabitViewController.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 9/5/23.
//

import UIKit
import SnapKit
import SwiftUI

class CreateHabitViewController: UIViewController {
	var createHabitPresenter: CreateHabitPresenter!
	
	//MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		config()
		addSubviews()
		setConstraint()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: - config
	
	func config() {
		createHabitPresenter = CreateHabitPresenter()
		hideKeyboardTappedAround()
		view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 100)
		descriptionTextView.delegate = self
	}
	
	func addSubviews() {
		view.addSubview(scroll)
		scroll.addSubview(contentView)
		
		contentView.addSubview(titleVC)
		contentView.addSubview(saveButton)
		
		contentView.addSubview(nameLabel)
		contentView.addSubview(nameField)
	
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(descriptionTextView)
		
		contentView.addSubview(measureLabel)
		contentView.addSubview(measureView)
		measureView.addSubview(measureNameField)
		measureView.addSubview(measureCountField)
				
		startView.addSubview(startDateLabel)
		startView.addSubview(startDate)
		contentView.addSubview(startView)
		
		contentView.addSubview(replayDateButton)
		
		finishView.addSubview(finishDateLabel)
		finishView.addSubview(finishDate)
		contentView.addSubview(finishView)
	}
	
	
	// MARK: - subviews
	
	let scroll: UIScrollView = {
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.isScrollEnabled = true
		return scroll
	}()
	
	let contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let titleVC: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Create Habit"
		label.font = .systemFont(ofSize: 30, weight: .bold)
		label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		return label
	}()
	
	let saveButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Save", for: .normal)
		button.addTarget(self, action: #selector(saveHabit), for: .touchUpInside)
		return button
	}()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Habit name"
		label.font = .systemFont(ofSize: 15, weight: .medium)
		label.textColor = .darkGray
		return label
	}()
	
	let nameField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = .systemFont(ofSize: 18, weight: .medium)
		textField.textColor = .white
		textField.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		textField.placeholder = "Name"
		textField.textAlignment = .left
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
		textField.leftViewMode = .always
		textField.layer.cornerRadius = 10
		return textField
	}()
	
	let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Habit description"
		label.font = .systemFont(ofSize: 15, weight: .medium)
		label.textColor = .darkGray
		return label
	}()
	
	let descriptionTextView: UITextView = {
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.text = "Description"
		textView.font = .systemFont(ofSize: 18, weight: .medium)
		textView.textColor = .placeholderDefaultColor
		textView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		textView.layer.cornerRadius = 10
		textView.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)
		return textView
	}()
	
	let measureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Measure"
		label.font = .systemFont(ofSize: 15, weight: .medium)
		label.textColor = .darkGray
		return label
	}()
	
	let measureView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 10
		view.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		view.layer.borderWidth = 2
		return view
	}()
	
	let measureNameField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = .systemFont(ofSize: 18, weight: .medium)
		textField.textColor = .white
		textField.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		textField.placeholder = "Name"
		textField.textAlignment = .center
		textField.layer.cornerRadius = 10
		return textField
	}()
	
	let measureCountField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = .systemFont(ofSize: 18, weight: .medium)
		textField.textColor = .white
		textField.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		textField.placeholder = "0"
		textField.keyboardType = .numberPad
		textField.textAlignment = .center
		textField.layer.cornerRadius = 10
		return textField
	}()
	
	let replayView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 10
		view.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		view.layer.borderWidth = 2
		return view
	}()
	
	let replayCountField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = .systemFont(ofSize: 18, weight: .medium)
		textField.textColor = .white
		textField.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		textField.placeholder = "0"
		textField.keyboardType = .numberPad
		textField.textAlignment = .center
		textField.layer.cornerRadius = 10
		return textField
	}()
	
	let replayDateButton: UIButton = {
		let button = UIButton()
		button.setTitle("Choose", for: .normal)
		button.backgroundColor = .red
		button.addTarget(self, action: #selector(changeReply), for: .touchUpInside)
		return button
	}()
	
	let startView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 10
		view.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		view.layer.borderWidth = 2
		return view
	}()
	
	let startDateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Start date"
		label.font = .systemFont(ofSize: 20, weight: .medium)
		label.textColor = .darkGray
		return label
	}()
	
	let startDate: UIDatePicker = {
		let date = UIDatePicker()
		date.translatesAutoresizingMaskIntoConstraints = false
		date.preferredDatePickerStyle = .compact
		date.datePickerMode = .date
		date.minimumDate = .now
		date.layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		date.layer.cornerRadius = 10
		return date
	}()
	
	let finishView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 10
		view.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		view.layer.borderWidth = 2
		return view
	}()
	
	let finishDateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Finish date"
		label.font = .systemFont(ofSize: 20, weight: .medium)
		label.textColor = .darkGray
		return label
	}()
	
	let finishDate: UIDatePicker = {
		let date = UIDatePicker()
		date.translatesAutoresizingMaskIntoConstraints = false
		date.preferredDatePickerStyle = .compact
		date.datePickerMode = .date
		date.minimumDate = .now
		date.layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		date.layer.cornerRadius = 10
		return date
	}()

	// MARK: - Actions
	
	@objc func changeReply() {
		createHabitPresenter.changeReply()
	}
	
	@objc func saveHabit() {
		print("hello")
	}

}

	// MARK: - constraint

extension CreateHabitViewController {
	func setConstraint() {
		scroll.snp.makeConstraints { make in
			make.size.equalToSuperview()
			make.height.equalToSuperview()
			make.width.equalToSuperview()
		}
		contentView.snp.makeConstraints { make in
			make.size.equalToSuperview()
			make.height.equalToSuperview()
			make.width.equalToSuperview()
		}
		saveButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalToSuperview().offset(15)
		}
		titleVC.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalToSuperview().offset(15)
		}
		nameLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalTo(titleVC.snp.bottom).offset(15)
		}
		nameField.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalTo(nameLabel.snp.bottom).offset(5)
			make.height.equalTo(50)
		}
		descriptionLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalTo(nameField.snp.bottom).offset(15)
		}
		descriptionTextView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
			make.height.equalTo(100)
		}
		measureLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalTo(descriptionTextView.snp.bottom).offset(15)
		}
		measureView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalTo(measureLabel.snp.bottom).offset(5)
			make.height.equalTo(startDate.frame.height + 20)
		}
		measureNameField.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.centerY.equalToSuperview()
			make.height.equalTo(startDate.frame.height)
			make.width.equalTo(200)
		}
		measureCountField.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(-10)
			make.centerY.equalToSuperview()
			make.height.equalTo(startDate.frame.height)
			make.width.equalTo(70)
		}
		
		
		startView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalTo(measureView.snp.bottom).offset(15)
			make.height.equalTo(startDate.frame.height + 20)
		}
		startDateLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(10)
			make.top.equalToSuperview().offset(15)
		}
		startDate.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(-10)
			make.top.equalToSuperview().offset(10)
		}
		finishView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
			make.top.equalTo(startView.snp.bottom).offset(15)
			make.height.equalTo(startDate.frame.height + 20)
		}
		finishDateLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(10)
			make.top.equalToSuperview().offset(15)
		}
		finishDate.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(-10)
			make.top.equalToSuperview().offset(10)
		}
		replayDateButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(10)
			make.top.equalTo(finishDate.snp.bottom).offset(15)
			make.height.equalTo(30)
			make.width.equalTo(100)
		}
	}
}

	// MARK: - Extensions

extension CreateHabitViewController: UITextViewDelegate {
	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		if textView.text == "Description" {
			textView.text = ""
			textView.textColor = .white
		}
		return true
	}

	func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
		if textView.text.isEmpty {
			textView.text = "Description"
			textView.textColor = .placeholderDefaultColor
		}
		return true
	}
}

extension UIViewController {
	func hideKeyboardTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc func dissmissKeyboard(){
		view.endEditing(true)
	}
}

extension UIColor {
	static var placeholderDefaultColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
}
