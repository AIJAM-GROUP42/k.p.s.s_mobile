//
//  QuizViewModel.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//
import Foundation

final class QuizViewModel {
    private let service: QuizServiceProtocol
    private(set) var questions: [QuizQuestion] = []
    private var correctAnswers: Int = 0
    private var answeredCount: Int = 0

    var onUpdate: (() -> Void)?
    var onSubmitted: ((String) -> Void)?

    init(service: QuizServiceProtocol) {
        self.service = service
    }

    func loadQuiz(topic: String) {
        service.fetchQuiz(for: topic) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quiz):
                    self?.questions = quiz
                    self?.onUpdate?()
                case .failure(let error):
                    print("Quiz fetch error:", error)
                }
            }
        }
    }

    func checkAnswer(questionIndex: Int, selectedIndex: Int) -> Bool {
        let correct = questions[questionIndex].answerIndex == selectedIndex
        if correct { correctAnswers += 1 }
        answeredCount += 1
        return correct
    }

    func quizFinished() -> Bool {
        return answeredCount == questions.count
    }

    func submitResults(userId: Int) {
        service.submitQuiz(userId: userId, correctCount: correctAnswers, score: correctAnswers) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self?.onSubmitted?(message)
                case .failure:
                    self?.onSubmitted?("Gönderim başarısız.")
                }
            }
        }
    }

    func scoreSummary() -> (correct: Int, total: Int) {
        (correctAnswers, questions.count)
    }
}
