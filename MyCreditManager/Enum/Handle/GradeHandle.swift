//
//  GradeHandle.swift
//  MyCreditManager
//
//  Created by 박준하 on 2023/04/24.
//

import Foundation

public enum GradeHandle {
    case add
    case delete
    case show
    
    static func addGrade() {
        excuteGradesMessage(.add)
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
    
    static func removeGrade() {
        
        excuteGradesMessage(.delete)
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
    
    static func showGrades() {

        excuteGradesMessage(.show)
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
}
