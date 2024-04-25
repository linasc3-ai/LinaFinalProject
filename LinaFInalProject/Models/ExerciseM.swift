//
//  Exercise.swift
//  FinalProj
//
//  Created by Colin  on 2024/4/22.
//

import Foundation

struct ExerciseM: Codable {
    var date: Date
    var steps: Int
    var duration: Int // duration in seconds
    var emotion: EmotionM
}
