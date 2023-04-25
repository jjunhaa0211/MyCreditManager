//
//  MyCreditManagerTest.swift
//  MyCreditManagerTest
//
//  Created by 박준하 on 2023/04/25.
//

import XCTest
//@testable import MyCreditManager

final class MyCreditManagerTest: XCTestCase {
    
//    var students: [String]!
//    var studentGrades: [String: [String: String]]!
    
    override class func setUp() {
        super.setUp()
        
        students = []
        studentGrades = [:]
    }

//    override class func tearDown() {
//        students = nil
//        studentGrades = nil
//        super.tearDown()
//    }
    
    func testAddStudent() {
        addStudent("Mickey")
        XCTAssertEqual(students.count, 1, "학생 테스트 추가 성공, 정상적으로 추가 성공 ❤️")
        addStudent("Mickey")
        XCTAssertEqual(students.count, 1, "학생 테스트 추가 실패, 중복 학생이 목록에 추가됨 😅")
    }
    
    func testDeleteStudent() {
        students.append("Mickey Swift")
        deleteStudent("Mickey Swift")
        XCTAssertEqual(students.count, 0, "학생 시험 삭제 실패, 학생이 목록에서 제거되지 않음 🤨")
        deleteStudent("Mickey Swift")
        XCTAssertEqual(students.count, 0, "학생 시험 삭제 실패, 학생을 찾을 수 없지만 목록에서 제거됨 🤙")
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
