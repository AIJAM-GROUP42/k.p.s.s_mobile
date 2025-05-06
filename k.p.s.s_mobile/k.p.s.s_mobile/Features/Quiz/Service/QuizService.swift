//
//  QuizService.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 6.05.2025.
//

import Foundation
import UIKit

final class QuizService: QuizServiceProtocol {
    func fetchQuiz(for topic: String, completion: @escaping (Result<[QuizQuestion], Error>) -> Void) {
        guard var components = URLComponents(string: "\(API.baseURL)/quiz/generate") else { return }
        components.queryItems = [URLQueryItem(name: "topic", value: topic)]

        guard let url = components.url else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(QuizResponse.self, from: data)
                completion(.success(decoded.quiz))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func submitQuiz(userId: Int, correctCount: Int, score: Int, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(API.baseURL)/quiz/submit") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = [
            "user_id": userId,
            "correct_count": correctCount,
            "score": score
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let message = json["message"] as? String else {
                completion(.failure(NSError(domain: "", code: -1)))
                return
            }
            completion(.success(message))
        }.resume()
    }
}
