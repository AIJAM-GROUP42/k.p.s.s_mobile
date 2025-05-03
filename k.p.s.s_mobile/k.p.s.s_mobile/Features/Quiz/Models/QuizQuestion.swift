//
//  Quiz.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

struct QuizQuestion: Codable {
    let id: Int
    let question: String
    let options: [String]
    let correctAnswer: String
}
