//
//  LessonServiceProtocol.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 6.05.2025.
//


protocol LessonServiceProtocol {
    func generateLesson(topic: String, userId: Int, completion: @escaping (Result<LessonResponse, Error>) -> Void)
}
