//
//  Errors+extension.swift
//  MyCreditManager
//
//  Created by 박준하 on 2023/04/24.
//

import Foundation

extension Errors: CustomStringConvertible {
    public var description: String {
        switch self {
        case .InvalidConditionInput:
            return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        case .InvalidInput:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
        case .AlreadyExist:
            return "은 이미 존재하는 학생입니다. 추가하지 않습니다."
        case .studentNotFound:
            return " 학생을 찾지 못했습니다."
        case .subjectNotFound:
            return " 과목을 찾지 못했습니다."
        }
    }
}
