//
//  PromptServiceProtocol.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 4.05.2025.
//

protocol PromptServiceProtocol {
    func fetchAIResponse(for topic: String, completion: @escaping (Result<AIResponse, Error>) -> Void)
}
