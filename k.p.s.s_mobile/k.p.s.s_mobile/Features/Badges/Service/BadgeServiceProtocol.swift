//
//  BadgeServiceProtocol.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

protocol BadgeServiceProtocol {
    func fetchBadges(for userId: Int, completion: @escaping (Result<[Badge], Error>) -> Void)
}
