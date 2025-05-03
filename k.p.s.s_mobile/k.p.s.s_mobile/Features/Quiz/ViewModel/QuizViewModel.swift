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
    private(set) var results: [QuizAnswerResult] = []
    var onUpdate: (() -> Void)?

    init(service: QuizServiceProtocol) {
        self.service = service
    }

    func loadQuiz() {
        service.fetchQuiz { [weak self] result in
            switch result {
            case .success(let questions):
                self?.questions = questions
                self?.onUpdate?()
            case .failure(let error):
                print("Quiz error: \(error)")
            }
        }
    }

    func recordAnswer(questionId: Int, selected: String, correct: String) {
        let result = QuizAnswerResult(
            questionId: questionId,
            selectedAnswer: selected,
            isCorrect: selected == correct
        )
        results.append(result)
    }

    // ✅ Yeni: sadece toplam doğru sayısını gönderiyoruz
    func submitCorrectCount(userId: Int, completion: @escaping () -> Void) {
        let correctCount = scoreSummary().correct
        let submission = QuizSubmission(userId: userId, correctCount: correctCount)

        service.submitQuiz(submission) { result in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                print("Skor gönderilemedi: \(error)")
            }
        }
    }

    func quizFinished() -> Bool {
        return results.count == questions.count
    }

    func scoreSummary() -> (correct: Int, wrong: Int) {
        let correct = results.filter { $0.isCorrect }.count
        let wrong = results.count - correct
        return (correct, wrong)
    }
}
