//
//  HomeViewModel.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 4.05.2025.
//

import Foundation
final class HomeViewModel {
    private let service: LessonServiceProtocol
    var onLessonLoaded: ((LessonResponse) -> Void)?
    var onError: ((String) -> Void)?

    init(service: LessonServiceProtocol) {
        self.service = service
    }

    func generateLesson(topic: String, userId: Int) {
        service.generateLesson(topic: topic, userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let lesson):
                    self?.onLessonLoaded?(lesson)
                case .failure:
                    self?.onError?("Konu yüklenemedi.")
                }
            }
        }
    }
}
