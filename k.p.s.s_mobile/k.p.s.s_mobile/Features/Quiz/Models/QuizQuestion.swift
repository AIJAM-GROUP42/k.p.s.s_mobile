//
//  Quiz.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

struct QuizQuestion: Codable {
    let question: String
    let options: [String]
    let answerIndex: Int

    enum CodingKeys: String, CodingKey {
        case question, options
        case answerIndex = "answer_index"
    }
}
