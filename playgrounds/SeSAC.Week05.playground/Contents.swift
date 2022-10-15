import UIKit
import Foundation

//고차함수: 1급 객체 / 매개변수와 반환값에 함수 -> map, filter, reduce

//학생 4.0 이상
let student = [2.2,2.9, 4.5, 4.2, 3.8, 3.7, 3.9, 2.8, 1.5]
var resultStudent: [Double] = []

for i in student {
    if i >= 4.0 {
        resultStudent.append(i)
    }
}
print(resultStudent)

//Filter

let resultFilter = student.filter { Value in
                    Value >= 4.0
                    }

let resultStudentFilter = student.filter { $0 >= 4.0 }
print(resultStudentFilter)

//원하는 영화
let movieList = [
    "괴물" : "박찬욱",
    "기생충" : "봉준호",
    "인터스텔라" : "크리스토퍼 놀란",
    "인셉션" : "크리스토퍼 놀란",
    "옥자" : "봉준호"
]

let resultSort = movieList.sorted(by: { $0.key < $1.key })
print(resultSort)


for (movieName, director) in movieList {
    if director == "봉준호"{
        print(movieName)
    }
}

let movieResult = movieList.filter { $0.value == "봉준호" }
print(movieResult)


let movieResult2 = movieList.filter { $0.value == "봉준호" }.map { $0.key }
print(movieResult2)

//map
let number = [1,2,3,4,5,6,7,8,9]
var resultNumber: [Int] = []

for n in number {
    let value = n * 2
    resultNumber.append(value)
}

let resultMap = number.map { $0 * 2 }
print(resultMap)


//reduce
let exam = [20 ,40, 80, 70, 60, 100, 70]
var totalCount = 0

for x in exam {
    totalCount += x
}

let resultExam = exam.reduce(0) { $0 + $1 }
print(resultExam)












//: [Next](@next)

