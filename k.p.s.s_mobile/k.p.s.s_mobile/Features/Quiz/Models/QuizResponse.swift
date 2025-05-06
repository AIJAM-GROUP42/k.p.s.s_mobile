//
//  QuizResponse.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 6.05.2025.
//


struct QuizResponse: Codable {
    let topic: String
    let quiz: [QuizQuestion]
}
