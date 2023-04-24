//
//  Alarm.swift
//  MyCreditManager
//
//  Created by 박준하 on 2023/04/24.
//

import Foundation

public enum Alarm {
    case addStudentSuccess(String)
    case removeStudentSuccess(String)
    
    var message: String {
        switch self {
        case .addStudentSuccess(let studentName):
            return "\(studentName) 학생을 추가했습니다."
        case .removeStudentSuccess(let studentName):
            return "\(studentName) 학생을 삭제하였습니다"
        }
    }
}
