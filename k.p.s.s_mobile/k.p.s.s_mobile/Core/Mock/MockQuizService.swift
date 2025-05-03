//
//  MockQuizService.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//
import Foundation
final class MockQuizService: QuizServiceProtocol {
    func fetchQuiz(completion: @escaping (Result<[QuizQuestion], Error>) -> Void) {
        let questions = [
            QuizQuestion(id: 1, question: "Atatürk'ün doğum yılı nedir?", options: ["1881", "1923", "1919", "1938"], correctAnswer: "1881"),
            QuizQuestion(id: 2, question: "TBMM hangi yılda açıldı?", options: ["1920", "1923", "1918", "1930"], correctAnswer: "1920"),
            QuizQuestion(id: 3, question: "Lozan Antlaşması ne zaman imzalandı?", options: ["1923", "1918", "1920", "1930"], correctAnswer: "1923")
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(questions))
        }
    }

    func submitQuiz(_ submission: QuizSubmission, completion: @escaping (Result<Void, Error>) -> Void) {
        let currentTotal = UserDefaults.standard.integer(forKey: "totalCorrectAnswers")
        let updatedTotal = currentTotal + submission.correctCount
        UserDefaults.standard.set(updatedTotal, forKey: "totalCorrectAnswers")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(()))
        }
    }
}
