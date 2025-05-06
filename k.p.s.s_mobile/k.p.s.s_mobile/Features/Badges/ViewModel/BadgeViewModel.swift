//
//  BadgeViewModel.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import Foundation

final class BadgeViewModel {
    private let service: BadgeServiceProtocol
    private(set) var badges: [Badge] = []
    var onUpdate: (() -> Void)?

    init(service: BadgeServiceProtocol) {
        self.service = service
    }

    func loadBadges(for userId: Int) {
        service.fetchBadges(for: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let badges):
                    self?.badges = badges
                    self?.onUpdate?()
                case .failure(let error):
                    print("Rozet yüklenemedi:", error)
                }
            }
        }
    }
}
