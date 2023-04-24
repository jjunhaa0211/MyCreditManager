//
//  Errors+extension.swift
//  MyCreditManager
//
//  Created by 박준하 on 2023/04/24.
//

import Foundation

extension Errors: CustomStringConvertible {
    var description: String {
        switch self {
        case .InvalidConditionInput:
            return "1~5 사이의 숫자 혹은 X를 입력해주세요."
        case .InvalidInput:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
        }
    }
}
