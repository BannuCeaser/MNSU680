//
//  SalaryViewModel.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/23/22.
//

import Foundation

class SalaryViewModel: ObservableObject {
    @Published var model: SalaryModel
    @Published var selectedRow: Datum?
    
    init(model: SalaryModel) {
        self.model = model
    }
    
    func getPlaceholder(searchChoice: SearchByType) -> String {
        switch searchChoice {
        case .department:
            return Constants.searchDeptPlaceholder
        case .college:
            return Constants.searchCollagePlaceholder
        }
    }
    
    func getSearchList(choice: SearchByType, sortBy: SortBy) -> [String]? {
        switch choice {
        case .department:
            switch sortBy {
            case .ascending:
                return model.data?.compactMap { $0.department }.uniqued().sorted(by: { first, second in
                    first < second
                })
            case .descending:
                return model.data?.compactMap { $0.department }.uniqued().sorted(by: { first, second in
                    first > second
                })
            }
            
        case .college:
            switch sortBy {
            case .ascending:
                return model.data?.compactMap { $0.college }.uniqued().sorted()
            case .descending:
                return model.data?.compactMap { $0.college }.uniqued()
            }
        }
    }
    
    func getSelected(serachChoice: SearchByType, rowItem: String) -> UniversitySubSection {
        switch serachChoice {
        case .department:
            return model.getDetails(for: rowItem, type: .department)
        case .college:
            return model.getDetails(for: rowItem, type: .college)
        }
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

enum SearchByType: String, CaseIterable, Identifiable {
    case department
    case college
    
    var id: SearchByType { self }
    
    var placehoderString: String {
        switch self {
        case .department:
            return Constants.searchDeptPlaceholder
        case .college:
            return Constants.searchCollagePlaceholder
        }
    }
}

enum SortBy: String, CaseIterable, Identifiable {
    case ascending
    case descending
    
    var id: SortBy { self }
}
