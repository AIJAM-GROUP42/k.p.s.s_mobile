//
//  MockBadgeService.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import Foundation

final class MockBadgeService: BadgeServiceProtocol {
    func fetchBadges(completion: @escaping (Result<[Badge], Error>) -> Void) {
        let totalCorrect = UserDefaults.standard.integer(forKey: "totalCorrectAnswers")

        var earnedBadges: [Badge] = []

        if totalCorrect >= 1 {
            earnedBadges.append(Badge(id: 1, title: "İlk Doğru", description: "İlk doğru cevabını verdin!"))
        }
        if totalCorrect >= 5 {
            earnedBadges.append(Badge(id: 2, title: "5 Doğru", description: "5 doğruya ulaştın."))
        }
        if totalCorrect >= 10 {
            earnedBadges.append(Badge(id: 3, title: "10 Doğru", description: "10 doğru ile efsane oldun!"))
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(earnedBadges))
        }
    }
}
