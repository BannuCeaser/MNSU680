//
//  SalaryModel.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/23/22.
//

import Foundation
import SwiftUI

// MARK: - Model
struct SalaryModel: Codable {
    let data: [Datum]?
}

extension Array where Element == Datum {
    
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

protocol UniversitySubSection {
    var id: String { get set}
    var employees: [Employee] { get set }
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
    
    func getDetails(for name: String, type: SearchByType) -> UniversitySubSection {
        var empList: [Employee] = []
        
        for empItem in data! {
            let emp = Employee(id: empItem.rndID, firstName: empItem.firstName, lastName: empItem.lastName, jobTitle: empItem.jobTitle, yearlyPay: empItem.payYearly, pay_ytd: empItem.payYtd, dept: empItem.department, clg: empItem.college)
            empList.append(emp)
        }
        
        switch type {
        case .department:
            let deptEmployees = empList.filter { $0.dept.lowercased() == name.lowercased() }
            return DepartmentDetails(id: name, employees: deptEmployees)
        case .college:
            let clgEmployees = empList.filter { $0.clg.lowercased() == name.lowercased() }
            return CollegeDetails(id: name, employees: clgEmployees)
        }
    }
}

struct DepartmentDetails: UniversitySubSection {
    var id: String
    var employees: [Employee]
}

struct CollegeDetails: UniversitySubSection {
    var id: String
    var employees: [Employee]
}

struct Employee: Codable, Hashable {
    var id: String
    var firstName: String
    var lastName: String
    var jobTitle: String
    var yearlyPay: Double
    var pay_ytd: Double
    var dept: String
    var clg: String
}

struct StatisticsData {
    var average: Double
    var median: Double
    var minSalary: Double
    var maxSalary: Double
}
