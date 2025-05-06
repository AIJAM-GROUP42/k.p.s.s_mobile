//
//  QuizServiceProtocol.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

protocol QuizServiceProtocol {
    func fetchQuiz(for topic: String, completion: @escaping (Result<[QuizQuestion], Error>) -> Void)
    func submitQuiz(userId: Int, correctCount: Int, score: Int, completion: @escaping (Result<String, Error>) -> Void)
}
