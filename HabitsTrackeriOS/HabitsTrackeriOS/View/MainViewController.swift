//
//  MainViewController.swift
//  HabitsTrackeriOS
//
//  Created by jarvis on 8/5/23.
//

import UIKit
import SwiftUI
import SnapKit

class MainViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
	var presenter: MainPresenter!
	let cellReuseIdentifier = "cell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		config()
		setupNavigationItem()
		setupTableView()
		setConstraint()
	}
	
	// MARK: config
	private func config() {
		presenter = MainPresenter()
		navigationController?.delegate = self
		presenter.view = self
		presenter.load()
		view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	}
	
	private func setupNavigationItem() {
		navigationItem.title = "My habits"
		let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
		navigationController?.navigationBar.titleTextAttributes = textAttributes
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
															style: .plain,
										  target: self,
										  action: #selector(signInAction))
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: nil)
	}
	
	// MARK: subviews
	let tableView: UITableView = UITableView()

	
	// MARK: Actions
	@objc func signInAction() {
		presenter.signInAction()
	}

	// MARK: tableView
	func setupTableView() {
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(CellHabbit.self, forCellReuseIdentifier: cellReuseIdentifier)
		tableView.separatorStyle = .none
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 10
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let view = UIView()
		return view
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return presenter.habits.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CellHabbit
		let habitModel = presenter.habits[indexPath.section]
		cell.setData(habit: habitModel)
		cell.selectionStyle = .none
		return cell
	}

	
	// MARK: constraint	
	func setConstraint() {
		tableView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.bottom.equalToSuperview()
			make.leading.equalToSuperview().offset(10)
			make.trailing.equalToSuperview().offset(-10)
		}
	}
}
