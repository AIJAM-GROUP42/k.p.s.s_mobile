//
//  MockPromptService.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//
import Foundation

final class MockPromptService: PromptServiceProtocol {
    func fetchAIResponse(for topic: String, completion: @escaping (Result<AIResponse, Error>) -> Void) {
        let response = AIResponse(
            info: "\(topic) hakkında temel bilgiler...\n\nLorem ipsum dolor sit amet...",
            memoryTip: "Bu konuyu 'hikayeleştirme' yöntemiyle zihninde canlandır."
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(response))
        }
    }
}
