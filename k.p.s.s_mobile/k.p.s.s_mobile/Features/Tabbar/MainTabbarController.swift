//
//  MainTabbarController.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Ana Sayfa", image: UIImage(systemName: "house"), tag: 0)

        let quizVC = UINavigationController(rootViewController: QuizViewController())
        quizVC.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(systemName: "pencil"), tag: 1)

        let badgeVC = UINavigationController(rootViewController: BadgeViewController())
        badgeVC.tabBarItem = UITabBarItem(title: "Rozetler", image: UIImage(systemName: "star"), tag: 2)

        viewControllers = [homeVC, quizVC, badgeVC]
        tabBar.tintColor = .systemBlue
    }
}
