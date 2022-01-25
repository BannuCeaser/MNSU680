//
//  SalaryModel.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/23/22.
//

import Foundation

// MARK: - Model
struct SalaryModel: Codable {
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let rndID: String
    let startDate: StartDate
    let department, college: String
    let division: Division
    let jobTitle: String
    let payYearly, payYtd: Double
    let tenured: String?
    let lastName, firstName: String

    enum CodingKeys: String, CodingKey {
        case rndID = "RND_ID"
        case startDate = "START_DATE"
        case department = "DEPARTMENT"
        case college = "College"
        case division = "Division"
        case jobTitle = "JOB_TITLE"
        case payYearly = "PAY_YEARLY"
        case payYtd = "PAY_YTD"
        case tenured = "TENURED"
        case lastName = "LAST_NAME"
        case firstName = "FIRST_NAME"
    }
}

enum Division: String, Codable {
    case academicAffairs = "Academic Affairs"
    case diversityInclusion = "Diversity & Inclusion"
    case facilitiesManagement = "Facilities Management"
    case financeAndAdministration = "Finance and Administration"
    case globalEducation = "Global Education"
    case itSolutions = "IT Solutions"
    case presidentSOffice = "President's Office"
    case strategicBUEDAndRegionalPartnershp = "Strategic BU, ED and Regional Partnershp"
    case studentAffairsEnrollmentManagement = "Student Affairs & Enrollment Management"
    case studentSuccessAnalyticsIntegPlann = "Student Success, Analytics & Integ Plann"
    case universityAdvancement = "University Advancement"
}

enum StartDate: Codable {
    case integer(Int)
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(StartDate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StartDate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

extension SalaryModel {
    static func loadFromFile(fileName: String) -> Self {
        let decoder = JSONDecoder()
        
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                print("file not found")
                return SalaryModel(data: nil)
            }
        do {
            let data = try Data(contentsOf: url)
            let model = try decoder.decode(SalaryModel.self, from: data)
            return model
        } catch {
            print(error)
        }
        
        return SalaryModel(data: nil)
    }
}
