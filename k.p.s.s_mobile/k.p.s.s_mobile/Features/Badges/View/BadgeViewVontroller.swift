//
//  BadgeViewVontroller.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import UIKit


final class BadgeViewController: UIViewController {
    private let viewModel = BadgeViewModel(service: BadgeService())
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rozetler"
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "badgeCell")
        tableView.frame = view.bounds
        view.addSubview(tableView)

        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }

        if let userId = UserDefaults.standard.integer(forKey: "user_id") as Int?, userId > 0 {
                    viewModel.loadBadges(for: userId)
                } else {
                    print("❗ User ID bulunamadı.")
                }
    }
}

extension BadgeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.badges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let badge = viewModel.badges[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "badgeCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "🏅 \(badge.title)\n\(badge.description)"
        return cell
    }
}
