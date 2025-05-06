//
//  LessonResponse.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 6.05.2025.
//


struct LessonResponse: Codable {
    let message: String
    let lessonId: Int
    let content: String
    let memoryTip: String

    enum CodingKeys: String, CodingKey {
        case message
        case lessonId = "lesson_id"
        case content
        case memoryTip = "memory_tip"
    }
}
