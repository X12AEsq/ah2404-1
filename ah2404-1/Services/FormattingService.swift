//
//  FormattingService.swift
//  ah2404
//
//  Created by Morris Albers on 2/21/23.
//

import Foundation
struct FormattingService {
    //
    //  MARK: GENERAL
    //
    public static func spc(len:Int) -> String {
        let spcs = ljf(base: "", len: len, zeroFill:false)
        return spcs
    }
    public static func rjf(base:String, len:Int, zeroFill:Bool) -> String {
        var workBase = base
        var workFill = " "
        if zeroFill {
            workFill = "0"
        }
        if workBase.count == len {
            return workBase
        }
        if workBase.count < len {
            while workBase.count < len {
                workBase = workFill + workBase
            }
        } else {
            while workBase.count > len {
                let work = workBase.dropLast(1)
                workBase = String(work)
            }
        }
        return workBase
    }
    
    public static func ljf(base:String, len:Int, zeroFill:Bool) -> String {
        var workBase = base
        if workBase.count == len {
            return workBase
        }
        if workBase.count < len {
            while workBase.count < len {
                if zeroFill {
                    workBase = workBase + "0"
                } else {
                    workBase = workBase + " "
                }
            }
        } else {
            while workBase.count > len {
                workBase = String(workBase.dropLast(1))
            }
        }
        return workBase
    }
    
    public static func deComposeNumber(inpnumber:String) -> [String] {
        if inpnumber == "" { return ["", ""] }
        let trimmedNumber = inpnumber.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedNumber == "" { return ["", ""] }

        let pieces = trimmedNumber.components(separatedBy: ".")
        if pieces.count == 2 { return pieces }
        if pieces.count == 1 { return pieces + ["0"] }
        return ["", ""]
    }
    
    public static func formatNumber(inpnumber:[String], decimals:Int) -> String {
        var lside = ""
        var rside = ""
        switch inpnumber.count {
        case 0:
            lside = "0"
            break
        case 1:
            lside = inpnumber[0]
            break
        case 2:
            lside = inpnumber[0]
            rside = inpnumber[1]
            break
        default:
            lside = "0"
            break
        }
        if inpnumber.count > 1 {
            lside = inpnumber[0]
            rside = inpnumber[1]
        }
        var rret = ""
        let myIntegerVariable = Int(lside) ?? 0
        let lret = String(myIntegerVariable)
        if decimals > 0 {
            rret = ljf(base:rside, len:decimals, zeroFill:true)
            return lret + "." + rret
        } else {
            return lret
        }
    }

}
