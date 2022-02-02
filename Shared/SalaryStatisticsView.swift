//
//  SalaryStatisticsView.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/29/22.
//

import SwiftUI

struct SalaryStatisticsView: View {
    var statisticsData: StatisticsData
    var body: some View {
        
        VStack(alignment: .center) {
            HStack {
                Text("Average Salary:").fontWeight(.medium)
                Spacer()
                Text("\(String(format: "%.2f", statisticsData.average))").font(.title3).foregroundColor(.blue).fontWeight(.bold)
            }.padding(20)
            
            HStack {
                Text("Median Salary:").fontWeight(.medium)
                Spacer()
                Text("\(String(format: "%.2f", statisticsData.median))").font(.title3).foregroundColor(.blue).fontWeight(.bold)
            }.padding(20)
            
            HStack {
                Text("Minimum Salary:").fontWeight(.medium)
                Spacer()
                Text("\(String(format: "%.2f", statisticsData.minSalary))").font(.title3).foregroundColor(.blue).fontWeight(.bold)
            }.padding(20)
            
            HStack {
                Text("Maximum Salary:").fontWeight(.medium)
                Spacer()
                Text("\(String(format: "%.2f", statisticsData.maxSalary))").font(.title3).foregroundColor(.blue).fontWeight(.bold)
            }.padding(20)
        }.padding().overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple, lineWidth: 1).padding(20)
        )
    }
}

struct SalaryStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryStatisticsView(statisticsData: StatisticsData(average: 0, median: 0, minSalary: 0, maxSalary: 0))
    }
}
