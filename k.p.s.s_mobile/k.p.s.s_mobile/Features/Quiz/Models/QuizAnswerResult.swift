//
//  QuizAnswerResult.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//


struct QuizAnswerResult: Codable {
    let questionId: Int
    let selectedAnswer: String
    let isCorrect: Bool
}
