//
//  DetailsViewModel.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/29/22.
//

import Foundation

class DetailsViewModel {
    var departmentData: UniversitySubSection?
    
    init(departmentData: UniversitySubSection) {
        self.departmentData = departmentData
    }
    
    func getAverage() -> Double {
        let payList: [Double] = departmentData?.employees.map { $0.yearlyPay } ?? []
       let avg = payList.average
       return avg
    }
    
    func getMedian() -> Double {
        let payList: [Double] = departmentData?.employees.map { $0.yearlyPay } ?? []
       let median = payList.median
       return median
    }
    
    func getMax() -> Double {
        return Double(departmentData?.employees.map { Int($0.yearlyPay) }.reduce(Int.min, { max($0, $1) }) ?? 0)
    }
    
    func getMin() -> Double {
        return Double(departmentData?.employees.map { Int($0.yearlyPay) }.reduce(Int.max, { min($0, $1) }) ?? 0)
    }
}

extension Array where Element: BinaryInteger {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }

}

extension Array where Element: BinaryFloatingPoint {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }
    
    var median: Double {
        let sorted = self.sorted()
          if sorted.count % 2 == 0 {
              return Double((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
          } else {
              return Double(sorted[(sorted.count - 1) / 2])
          }
    }
}
