//
//  DataManager.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/23/22.
//

import Foundation

struct DataManager {
    static func getSalaryModel(from fileName: String) -> SalaryModel? {
       return SalaryModel.loadFromFile(fileName: Constants.jsonFileName)
    }
}
