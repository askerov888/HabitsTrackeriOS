//
//  CellHabbit.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 8/5/23.
//

import Foundation
import UIKit
import SnapKit

class CellHabbit: UITableViewCell {
	var rep = 0
	
	// MARK: - subviews
	
	let title: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	let aimText: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	let buttonPlus: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		let image = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
		button.setImage(image, for: .normal)
		button.backgroundColor = #colorLiteral(red: 0.03601399809, green: 0.9306482673, blue: 0.3469707966, alpha: 1)
		button.layer.cornerRadius = 10
		return button
	}()
	
	let buttonMinus: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		let image = UIImage(systemName: "minus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
		button.setImage(image, for: .normal)
		button.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
		button.layer.cornerRadius = 10
		return button
	}()
	
	let countLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textColor = .white
		label.textAlignment = .center
		label.text = "0"
		return label
	}()
	
	// MARK: - actions
	
	@objc func plusAction() {
		let intText = Int(countLabel.text!)! + 1
		if intText <= rep {
			countLabel.text = String(intText)
		}
	}
	
	@objc func minusAction() {
		let intText = Int(countLabel.text!)! - 1
		if intText <= 0 {
			countLabel.text = "0"
		} else {
			countLabel.text = String(intText)
		}
	}
	
	// MARK: - setup
	
	func setupView() {
		contentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		contentView.layer.cornerRadius = 10
		contentView.layer.borderColor = UIColor.black.cgColor
		contentView.layer.borderWidth = 2
		buttonPlus.addTarget(self, action: #selector(plusAction), for: .touchUpInside)
		buttonMinus.addTarget(self, action: #selector(minusAction), for: .touchUpInside)
	}
	
	func setData(habit: Habit) {
		title.text = habit.title
		habit.measure.forEach { (key, value) in
			aimText.text = String(key)
			aimText.text! += " \(value)"
		}
		habit.schedule.forEach { key, _ in
			rep = key
		}
	}
	
	// MARK: - init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(title)
		contentView.addSubview(aimText)
		contentView.addSubview(buttonPlus)
		contentView.addSubview(buttonMinus)
		contentView.addSubview(countLabel)
		setupConstraint()
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - constraint
	
	func setupConstraint() {
		title.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(20)
			make.centerY.equalToSuperview()
		}
		aimText.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(-20)
			make.centerY.equalToSuperview()
		}
		buttonPlus.snp.makeConstraints { make in
			make.leading.equalTo(countLabel.snp.trailing).offset(10)
			make.centerY.equalToSuperview()
			make.height.equalToSuperview().offset(-20)
			make.width.equalTo(50)
		}
		buttonMinus.snp.makeConstraints { make in
			make.trailing.equalTo(countLabel.snp.leading).offset(-10)
			make.centerY.equalToSuperview()
			make.height.equalToSuperview().offset(-20)
			make.width.equalTo(50)
		}
		countLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}
