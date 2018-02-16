//
//  DataHelper.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 16.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class DateHelper: NSObject {
    static func getDateTimeStamp() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy-hh:mm:ss"
        return formatter.string(from: date)
    }
}
