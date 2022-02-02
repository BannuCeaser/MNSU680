//
//  DetailView.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/23/22.
//

import SwiftUI
import Charts

struct DetailView: View {
    var selectedRow: UniversitySubSection
    
    var viewModel: DetailsViewModel {
        DetailsViewModel(departmentData: selectedRow)
    }
    
    var body: some View {
        SalaryStatisticsView(statisticsData: StatisticsData(average: viewModel.getAverage(), median: viewModel.getMedian(), minSalary: viewModel.getMin(), maxSalary: Double(viewModel.getMax())))
        Spacer()
        
        NavigationLink(destination: EmployeeList(employeeList: selectedRow.employees)) {
            Text("View Employee List")
                .font(.title2)
                .fontWeight(.medium)
                .padding()
                .background(Color.orange)
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(40)
        }
    }
}
