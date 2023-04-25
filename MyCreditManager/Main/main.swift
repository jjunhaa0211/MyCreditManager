//
//  main.swift
//  MyCreditManager
//
//  Created by 박준하 on 2023/04/24.
//

import Foundation

public var students: [String] = []
public var studentGrades: [String: [String: String]] = [:]

public func isDuplicateName(name: String, in array: [String]) -> Bool {
    return array.contains(name)
}

public func addStudent(_ inputName: String) {
    if isDuplicateName(name: inputName, in: students) {
        print("\(inputName)\(Errors.AlreadyExist)")
        return
    }
    students.append(inputName)
    
    let studentsName = Alarm.addStudentSuccess(inputName)
    print(studentsName.message)
}

public func deleteStudent(_ inputName: String) {
    if let index = students.firstIndex(of: inputName) {
        students.remove(at: index)
        let studentsName = Alarm.removeStudentSuccess(inputName)
        print(studentsName.message)
    } else {
        print("\(inputName)\(Errors.studentNotFound)")
    }
}

while (1 != 0) {
    print("원하는 기능을 입력해주세요.")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")

    let input = readLine()
    
    switch input {
    case "1":
        StudentHandle.handleStudent(.add)
    case "2":
        StudentHandle.handleStudent(.delete)
    case "3":
        GradeHandle.addGrade()
    case "4":
        GradeHandle.removeGrade()
    case "5":
        GradeHandle.showGrades()
    case "X":
        print("프로그램을 종료합니다...")
        exit(0)
    default:
        print(Errors.InvalidConditionInput)
    }
}
