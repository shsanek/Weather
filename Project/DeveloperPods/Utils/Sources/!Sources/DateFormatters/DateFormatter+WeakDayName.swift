//
//  DateFormatter+WeakDayName.swift
//  Utils
//
//  Created by Alex Shipin on 11.08.2020.
//

import Foundation

extension DateFormatter
{

    public static var weakDayNameFormatter: DateFormatter {
        let result = DateFormatter()
        result.dateFormat = "EEEE"
        return result
    }

}
