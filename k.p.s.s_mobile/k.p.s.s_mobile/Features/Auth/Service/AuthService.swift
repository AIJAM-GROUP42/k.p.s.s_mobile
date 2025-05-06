//
//  AuthService.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 6.05.2025.
//
import Foundation
final class AuthService: AuthServiceProtocol {
 
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(API.baseURL)/auth/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let token = json["access_token"] as? String else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }

            completion(.success(token))
        }.resume()
    }
    
    func signup(name: String, surname: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
            guard let url = URL(string: "\(API.baseURL)/auth/signup") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let payload = [
                "name": name,
                "surname": surname,
                "email": email,
                "password": password
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let message = json["message"] as? String else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                    return
                }

                completion(.success(message))
            }.resume()
        }
}
