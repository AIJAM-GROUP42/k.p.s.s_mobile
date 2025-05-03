//
//  BadgeViewModel.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import Foundation

final class BadgeViewModel {
    private let service: BadgeServiceProtocol
    var badges: [Badge] = []
    var onUpdate: (() -> Void)?

    init(service: BadgeServiceProtocol) {
        self.service = service
    }

    func loadBadges() {
        service.fetchBadges { [weak self] result in
            switch result {
            case .success(let badges):
                self?.badges = badges
                self?.onUpdate?()
            case .failure(let error):
                print("Rozetler yüklenemedi: \(error)")
            }
        }
    }
}
