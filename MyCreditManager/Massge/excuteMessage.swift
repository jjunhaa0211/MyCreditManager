//
//  excuteMessage.swift
//  MyCreditManager
//
//  Created by 박준하 on 2023/04/24.
//

import Foundation

func excuteStudentMessage(_ status: StudentHandle) -> Void {
    switch status {
    case .add:
        print("추가할 학생의 이름을 입력해주세요")
    case .delete:
        print("삭제할 학생의 이름을 입력해주세요")
    }
}

func excuteGradesMessage(_ status: GradeHandle) -> Void {
    switch status {
    case .add:
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F)을 띄어쓰기로 구분하여 차례로 작성해주세요")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    case .delete:
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력 예) Mickey Swift")
    case .show:
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
    }
}
