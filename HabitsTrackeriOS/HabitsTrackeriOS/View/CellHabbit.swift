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
	
	// MARK: subviews
	
	let title: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	let aimText: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	
	// MARK: setup
	
	func setupView() {
		contentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		contentView.layer.cornerRadius = 15
	}
	
	func setData(habit: Habit) {
		title.text = habit.title
		habit.aim.forEach { (key, value) in
			aimText.text = String(key)
			aimText.text! += " \(value)"
		}
	}
	
	// MARK: init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(title)
		contentView.addSubview(aimText)
		setupConstraint()
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: constraint
	
	func setupConstraint() {
		title.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(20)
			make.centerY.equalToSuperview()
		}
		
		aimText.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(-20)
			make.centerY.equalToSuperview()
		}
	}
}
