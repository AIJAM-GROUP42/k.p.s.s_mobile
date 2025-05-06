//
//  BadgeService.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 6.05.2025.
//

import Foundation

final class BadgeService: BadgeServiceProtocol {
    func fetchBadges(for userId: Int, completion: @escaping (Result<[Badge], Error>) -> Void) {
        let urlString = "https://web-production-8488.up.railway.app/badges/\(userId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                struct Response: Codable {
                    let badges: [Badge]
                }

                let decoded = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(decoded.badges))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
