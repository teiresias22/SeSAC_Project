import UIKit

var str1 = "\u{1F1FA}"
var str2 = "\u{1F1F8}"
var str3 = str1 + str2

str1.count
str2.count
str3.count

var str4 = "\u{E9}"
var str5 = "\u{20DD}"
var str6 = str4 + str5

str1.count
str2.count
str3.count

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
let word = "Hello"

for index in stride(from: 0, to: word.count, by: 1) {
    print(word[index])
}




func readLine() -> String {
    return "dd"
}
let input = readLine().map{ String($0) }
var result = 0

if input[0] == "c" {
    result = 26
} else {
    result = 10
}
    
for i in 1...input.count-1 {
    if input[i-1] == input[i] {
        if input[i] == "c" {
            result *= 25
        } else {
            result *= 9
        }
    } else {
        if input[i] == "c" {
            result *= 26
        } else {
            result *= 10
        }
    }
}

print(result)
