//
//  EmployeeDetailsRow.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/29/22.
//

import SwiftUI

struct EmployeeList: View {
    var employeeList: [Employee]?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    Text("ID").font(.title3).foregroundColor(.blue)
                    Spacer()
                    Text("First Name").font(.title3).foregroundColor(.blue)
                    Spacer()
                    Text("Last Name").font(.title3).foregroundColor(.blue)
                    Spacer()
                    Text("Job Title").font(.title3).foregroundColor(.blue)
                    Spacer()
                }
                
                List {
                    ForEach(employeeList ?? [], id: \.self) { emp in
                        HStack() {
                            Text("\(emp.id)").font(.body).foregroundColor(.black).padding()
                            Spacer()
                            Text("\(emp.firstName)").font(.body).foregroundColor(.black).padding()
                            Spacer()
                            Text("\(emp.lastName)").font(.body).foregroundColor(.black).padding()
                            Spacer()
                            Text("\(emp.jobTitle)").font(.body).foregroundColor(.black).padding()
                        }
                    }
                }
            }
        }
    }
}

struct EmployeeList_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeList()
    }
}
