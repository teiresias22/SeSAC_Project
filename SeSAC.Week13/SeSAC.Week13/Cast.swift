//
//  Cast.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/07.
//

import Foundation

// MARK: - Cast
struct Cast: Codable {
    let peopleListResult: PeopleListResult
}

// MARK: - PeopleListResult
struct PeopleListResult: Codable {
    let totCnt: Int
    let peopleList: [PeopleList]
    let source: String
}

// MARK: - PeopleList
struct PeopleList: Codable {
    let peopleCD, peopleNm, peopleNmEn, repRoleNm, filmoNames: String

    enum CodingKeys: String, CodingKey {
        case peopleCD = "peopleCd"
        case peopleNm, peopleNmEn, repRoleNm, filmoNames
    }
}
