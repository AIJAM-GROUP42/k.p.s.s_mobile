//
//  HomeViewModel.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 4.05.2025.
//

final class HomeViewModel {
    private let service: PromptServiceProtocol

    var onResponseReceived: ((AIResponse) -> Void)?

    init(service: PromptServiceProtocol) {
        self.service = service
    }

    func sendPrompt(_ topic: String) {
        service.fetchAIResponse(for: topic) { [weak self] result in
            switch result {
            case .success(let response):
                self?.onResponseReceived?(response)
            case .failure(let error):
                print("AI response error: \(error)")
            }
        }
    }
}
