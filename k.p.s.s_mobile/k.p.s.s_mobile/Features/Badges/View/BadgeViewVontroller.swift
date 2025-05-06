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
        title = "Beyno Ödülleri"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.register(BadgeCardCell.self, forCellReuseIdentifier: BadgeCardCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
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

        viewModel.onError = { [weak self] message in
            self?.showErrorAlert(title: "Rozet Hatası", message: message)
        }
    }

    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

extension BadgeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.badges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let badge = viewModel.badges[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BadgeCardCell.identifier, for: indexPath) as? BadgeCardCell else {
            return UITableViewCell()
        }
        cell.configure(with: badge)
        return cell
    }
}
