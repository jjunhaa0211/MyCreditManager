//
//  StudentHandle.swift
//  MyCreditManager
//
//  Created by 박준하 on 2023/04/24.
//

import Foundation

public enum StudentHandle {
    case add
    case delete
    
    static func handleStudent(_ status: StudentHandle){
        excuteStudentMessage(status)
        guard let inputName = readLine(), !inputName.isEmpty else {
            print(Errors.InvalidConditionInput)
            return
        }
        status.excuteHandlerByStatus(status, inputName)

    }
    
    private func excuteHandlerByStatus(_ status: StudentHandle, _ inputName: String){
        switch(status){
        case .add:
            addStudent(inputName)
        case .delete:
            deleteStudent(inputName)
        }
    }
}
