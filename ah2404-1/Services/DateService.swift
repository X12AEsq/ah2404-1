//
//  DateService.swift
//  ah2404
//
//  Created by Morris Albers on 2/21/23.
//

import Foundation
struct DateService {
    public static func dateExt2Int(inDate:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let returnDate = formatter.string(from: inDate)
        return returnDate
    }
    
    public static func splitDateTime(inDate:Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm"
        let workSplitDate = formatter.string(from: inDate)
        if workSplitDate == "" { return ["", "", "", "", ""] }
        let trimmedDate = workSplitDate.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedDate == "" { return ["", "", "", "", ""] }

        var pieces = trimmedDate.components(separatedBy: "-")
        while pieces.count < 8 { pieces.append("") }
        pieces[0] = FormattingService.rjf(base: pieces[0], len: 4, zeroFill: true)
        pieces[1] = FormattingService.rjf(base: pieces[1], len: 2, zeroFill: true)
        pieces[2] = FormattingService.rjf(base: pieces[2], len: 2, zeroFill: true)
        pieces[3] = FormattingService.rjf(base: pieces[3], len: 2, zeroFill: true)
        pieces[4] = FormattingService.rjf(base: pieces[4], len: 2, zeroFill: true)
        pieces[5] = pieces[0] + "-" + pieces[1] + "-"  + pieces[2]
        pieces[6] = pieces[3] + pieces[4]
        pieces[7] = pieces[0] + pieces[1] + pieces[2]

        return pieces
    }
}
