//
//  QuizServiceProtocol.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

protocol QuizServiceProtocol {
    func fetchQuiz(completion: @escaping (Result<[QuizQuestion], Error>) -> Void)
    func submitQuiz(_ submission: QuizSubmission, completion: @escaping (Result<Void, Error>) -> Void)
}
