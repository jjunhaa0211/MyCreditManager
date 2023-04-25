<img width="1180" alt="스크린샷 2023-04-25 오전 10 51 55" src="https://user-images.githubusercontent.com/102890390/234155203-f7af4227-20bc-425a-8000-f47cbb6896c8.png">

# 성적 관리 프로그램

## **프로젝트 이름**

- MyCreditManager

## 사용 언어 / 환경

- Swift
- Xcode 기본 템플릿 중 [macOS - Command Line Tool]

## **프로그램의 메뉴**

- 학생추가
- 학생삭제
- 성적추가(변경)
- 성적삭제
- 평점보기
- 종료

## **프로그램 동작조건**

- 사용자가 종료 메뉴를 선택하기 전까지는 계속해서 사용자의 입력을 받습니다
- 메뉴선택을 포함한 모든 입력은 숫자 또는 영문으로 받습니다

## 성적별 점수

- A+ (4.5점) / A (4점)
- B+ (3.5점) / B (3점)
- C+ (2.5점) / C (2점)
- D+ (1.5점) / D (1점)
- F (0점)

## 평점

- 각 과목의 점수 총 합 / 과목 수
- 최대 소수점 2번째 자리까지 출력
    - 예)
        - 3.75
        - 4.1
        - 2

## 코드 설명

## Errors

```swift
public enum Errors: Error {
    case InvalidConditionInput // 조건 입력 잘못
    case InvalidInput // 입력 잘못
    case AlreadyExist // 중복
    case studentNotFound // 찾지 못함
    case subjectNotFound // 찾지 못함
}
```

```swift
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
```

Error가 났을 때 `thorw`를 사용하는 것은 Command Line Tool에 맞지 않다고 생각해서 `Error`라는 `enum`을 `CustomStringConvertible` 프로토콜을 사용해서 디버깅 및 출력용도에 맞도록 변환 해주었습니다.

## Alarm

```swift
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
```

`switch` 구문을 사용하여 `self`값에 따라서 문자열을 반환을 결정합니다.

예를 들어서 `self`가 **`.addStudentSuccess` `case` 인 경우 `let studentName`은 `addStudentSuccess` 연관 값을 바인딩한 코드가 됩니다. 때문에 `studentName`이라는 이름으로 `addStudentSucces` `case`의 연관 값이 할당됩니다.**

## excuteMessage

```swift
public func excuteStudentMessage(_ status: StudentHandle) -> Void {
    switch status {
    case .add:
        print("추가할 학생의 이름을 입력해주세요")
    case .delete:
        print("삭제할 학생의 이름을 입력해주세요")
    }
}

public func excuteGradesMessage(_ status: GradeHandle) -> Void {
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
```

`excuteStudentMessage`의 같은 경우에는 `switch`로 나누어준 이유가 있습니다. 지금은 딱 정해진 기능이 있지만 만약 학생의 주소를 입력하는 코드 등등 이 추가되게 되면 계속 `print`를 찍어야합니다. 하지만 `excuteStudentMessage`를 만들어서 학생 관련 함수를 만들어서 메세지를 출력하는 것을 만들면 코드의 유지보수가 편해지고 기존에 함수는 상속이 불라능하지만 이와 같은 방법으로 상속? 을 할 수 있다고 생각했습니다. `excuteGradesMessage` 역시 위해 설명한 그대로 입니다.

## StudentHandle + main

```swift
//StudentHandle
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

//main에 Student 코드만
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
```

저는 원래 `class`로 디자인 패턴을 공부했습니다. 원래는 **`Flyweight(상속 디자인 패턴)`를 사용해서 적용할까 생각했습니다. 그런데 모든 객체지향패턴을 `class`로 공부했기 때문에 구조체와 `enum`을 사용하고 싶어서 조금 `enum`의 극단적 예시라고 생각해주세요…..😅 저는 class는 상속이라는 개념이 있지만 함수에는 상속이라는 개념을 어떻게 할까 하다가 `Handle`을 만들어서 기능끼리 나누었습니다.** `excuteHandlerByStatus`를 보면 학생 추가와 학생 삭제는 학생의 이름을 받는 다는 공통점이 있습니다. 그래서 두개를 합쳤습니다. 그러면 성적관련도 이름을 받는데 왜? 거기에는 쓰지 않았냐? 라고 물어보신다면 아무래도 저는 관계 때문에 학생과 성적은 따로 유지해야 가독성이 좋지않나….라고 생각해서 적용하지 않았으며 `inputName`는 비어있을 경우에는 에러처리가 됩니다. 학생 삭제의 경우에는 비어있는 검사는 똑같지만 `isDuplicateName` 사용해서 배열에 중복 검사를 해서 중복되면 저장하지 않습니다.

## GradeHandle

```swift
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
```

솔직히 이 부분에서 `class`로 옮길까? 라는 생각을 많이 했습니다. 이런 식으로 하면 `Enum`에 너무 방대한 데이터가 생겼다고 생각합니다. 이렇게 되면 차라리 `class`로 바꿀까? 또는 그냥 공통점이 없기 때문에 `main`으로 빼서 함수처럼 사용할까? 했지만 `StudentHandle`를 만들어서 나눠 놓았기 때문에 `GradeHandle`을 나누었습니다. 그리고 `addGrade`를 보시면 `if`문보다는 `guard`로 `input`에 들어가는 내용들에 조건을 넣으면서 코드의 가독성이 좋아졌다고 생각합니다. 

## MyCreditManagerTest

```swift
override class func setUp() {
        super.setUp()
        
        students = []
        studentGrades = [:]
    }
    
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
    
    func testAlarm() {
        print("-------------------------Alarm-------------------------")
        let studentsName1 = Alarm.addStudentSuccess("junha1")
        print("\(studentsName1.message)")
        let studentsName2 = Alarm.removeStudentSuccess("junha2")
        print("\(studentsName2.message)")
        print("-------------------------Alarm-------------------------")
    }
    
    func testErrors() {
        print("-------------------------ERROR-------------------------")
        print(Errors.InvalidConditionInput)
        print(Errors.InvalidInput)
        print(Errors.AlreadyExist)
        print(Errors.studentNotFound)
        print(Errors.subjectNotFound)
        print("-------------------------ERROR-------------------------")
    }
```

테스트 코드는 `student`를 추가 하는 코드와 중복검사를 구현해보았고 `Student`를 삭제 했을 경우 삭제한 학생을 삭제 했을 경우를 테스트 코드로 만들었습니다. `testAlarm`은 `Alarm`이 잘나오나 확인한 것이고 `testErrors`도 마찬가지입니다.

마지막으로 `XCTest`에서 사용하는 `XCTAssertEqual`을 사용하면 위 코드에서는 `students.count`와 0이 같은지 확인 합니다. 만약 0이 아니라면 실패 메시지를 출력합니다.저는 학생 목록에서 제거할 때 해당 목록에 없는지 있는지 궁금해서 사용했습니다.
