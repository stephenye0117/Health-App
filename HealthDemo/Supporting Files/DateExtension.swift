//
//  DateExtension.swift
//  Health
//
//  Created by Steward Lynch (https://youtube.com/watch?v=d8KYAeBDQAQ) on 12/10/24.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
