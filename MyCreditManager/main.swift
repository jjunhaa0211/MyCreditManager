//
//  main.swift
//  MyCreditManager
//
//  Created by 박준하 on 2023/04/24.
//

import Foundation

var students: [String] = []
var studentGrades: [String: [String: String]] = [:]

enum Errors: Error {
    case InvalidConditionInput
    case InvalidInput
    case AlreadyExist
    case studentNotFound
    case subjectNotFound
}

enum Alarm {
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

enum Grades: String {
    case APlus = "A+"
    case A = "A"
    case BPlus = "B+"
    case B = "B"
    case CPlus = "C+"
    case C = "C"
    case DPlus = "D+"
    case D = "D"
    case F = "F"
    var score: Double {
        switch self {
        case .APlus:
            return 4.5
        case .A:
            return 4.0
        case .BPlus:
            return 3.5
        case .B:
            return 3.0
        case .CPlus:
            return 2.5
        case .C:
            return 2.0
        case .DPlus:
            return 1.5
        case .D:
            return 1.0
        case .F:
            return 0.0
        }
    }
}

func desiredFunction() {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
}

func isDuplicateName(name: String, in array: [String]) -> Bool {
    return array.contains(name)
}

func addStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    guard let inputName = readLine(), !inputName.isEmpty else {
        print(Errors.InvalidInput)
        return
    }
    
    if isDuplicateName(name: inputName, in: students) {
        print("\(inputName)\(Errors.AlreadyExist)")
        return
    }
    
    students.append(inputName)
    let studentsName = Alarm.addStudentSuccess(inputName)
    print(studentsName.message)
}

func deleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    guard let inputName = readLine(), !inputName.isEmpty else {
        print(Errors.InvalidInput)
        return
    }
    
    if let index = students.firstIndex(of: inputName) {
        students.remove(at: index)
        let studentsName = Alarm.removeStudentSuccess(inputName)
        print(studentsName.message)
    } else {
        print("\(inputName)\(Errors.studentNotFound)")
    }
}

func addGrades() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F)을 띄어쓰기로 구분하여 차례로 작성해주세요")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    guard let input = readLine()?.split(separator: " ").map({ String($0) }),
          input.count == 3,
          let name = input.first,
          let subject = input.dropFirst().first,
          let gradeString = input.last,
          let grade = Grades(rawValue: gradeString) else {
        print("\(Errors.InvalidInput)")
        return
    }
    
    if students.firstIndex(of: name) != nil {
        if studentGrades[name] == nil {
            studentGrades[name] = [subject: grade.rawValue]
        } else {
            studentGrades[name]?[subject] = grade.rawValue
        }
        print("\(name) 학생의 \(subject) 과목이 \(gradeString)로 추가(변경)되었습니다.")
    } else {
        print("\(name)\(Errors.studentNotFound)")
    }
}

func removeGrade() {
    
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력 예) Mickey Swift")
    let input = readLine() ?? ""
    let inputs = input.split(separator: " ").map(String.init)
    
    guard inputs.count == 2 else {
        print(Errors.InvalidInput)
        return
    }
    
    let name = inputs[0]
    let subject = inputs[1]
    
    guard let gradesOfStudent = studentGrades[name] else {
        print("\(name)\(Errors.studentNotFound)")
        return
    }
    
    guard let _ = gradesOfStudent[subject] else {
        print("\(subject)\(Errors.subjectNotFound)")
        return
    }
    
    studentGrades[name]!.removeValue(forKey: subject)
    print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
}

func showGrades() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    let name = readLine() ?? ""
    
    if name.isEmpty {
        print(Errors.InvalidInput)
        return
    }
    
    if let gradesOfStudent = studentGrades[name] {
        var totalGradeScore: Double = 0.0
        
        for (subject, grade) in gradesOfStudent {
            let gradeScore = Grades(rawValue: grade)?.score ?? 0.0
            totalGradeScore += gradeScore
            print("\(subject): \(grade)")
        }
        
        let averageGradeScore = totalGradeScore / Double(gradesOfStudent.count)
        
        print("평점: \(averageGradeScore)")
    } else {
        print("\(name)\(Errors.studentNotFound)")
    }
}



while (1 != 0) {
    desiredFunction()
    let input = readLine()
    
    switch input {
    case "1":
        addStudent()
    case "2":
        deleteStudent()
    case "3":
        addGrades()
    case "4":
        removeGrade()
    case "5":
        showGrades()
    case "X":
        print("프로그램을 종료합니다...")
        exit(0)
    default:
        print(Errors.InvalidConditionInput)
    }
}
