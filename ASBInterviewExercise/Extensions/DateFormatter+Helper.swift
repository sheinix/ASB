//
//  DateFormatter.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    return formatter
  }()
}
