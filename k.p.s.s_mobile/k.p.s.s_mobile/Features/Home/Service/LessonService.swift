//
//  LessonService.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 6.05.2025.
//
import Foundation
import UIKit

final class LessonService: LessonServiceProtocol {
    func generateLesson(topic: String, userId: Int, completion: @escaping (Result<LessonResponse, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "\(API.baseURL)/generate-lesson") else { return }

        urlComponents.queryItems = [
            URLQueryItem(name: "topic", value: topic),
            URLQueryItem(name: "user_id", value: "\(userId)")
        ]

        guard let url = urlComponents.url else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(LessonResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
