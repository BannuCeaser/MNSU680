//
//  ContentView.swift
//  MNSU-Salaries
//
//  Created by Bhavani Nainala on 1/23/22.
//

import SwiftUI

struct ContentView: View {
    let viewModel = SalaryViewModel(model: DataManager.getSalaryModel(from: Constants.jsonFileName) ?? SalaryModel(data: nil))
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let ySearchBar: CGFloat = 40
    var placeholderString = ""
    
    @State private var searchText : String = ""
    @State private var searchChoice : SearchByType = .department
    @State private var sortBY : SortBy = .ascending

    var body: some View {
        NavigationView {
            VStack(spacing: 0, content: {
                HStack(alignment: .firstTextBaseline) {
                    Text("Choose One:").padding(10).foregroundColor(.orange)
                    VStack {
                        Picker("", selection: $searchChoice) {
                            ForEach(SearchByType.allCases) { eachCase in
                                Text(eachCase.rawValue.capitalized)
                                }
                        }
                    }
                }.frame(alignment: .leading)
                
                HStack(alignment: .firstTextBaseline) {
                    Spacer()
                    Text("      Sort By:").padding(10).foregroundColor(.orange)
                    Picker("", selection: $sortBY) {
                        ForEach(SortBy.allCases) { eachCase in
                            Text(eachCase.rawValue.capitalized)
                            }
                    }
                    Spacer()
                }
               
                SearchBar(text: $searchText, placeholder: $searchChoice).position(x: UIScreen.main.bounds.width / 2, y: ySearchBar)
                    if !searchText.isEmpty {
                        List {
                            ForEach(self.viewModel.getSearchList(choice: searchChoice, sortBy: sortBY)?.filter {
                                self.searchText.isEmpty ? true : $0.lowercased().contains(self.searchText.lowercased())
                            } ?? ["dummy dept"], id: \.self) { row in
                                NavigationLink<HStack<TupleView<(Text, Spacer)>>, DetailView> {
                                    DetailView(selectedRow: viewModel.getSelected(serachChoice: searchChoice, rowItem: row))
                                                } label: {
                                                    HStack {
                                                        Text(row).foregroundColor(.blue)
                                                        Spacer()
                                                    }
                                                }
                                
                                
                            }
                        }.frame(width: screenWidth, height: screenHeight - (ySearchBar + 300), alignment: .center)
                        
                        Spacer()
                    } else {
                        Text("No Results Found").position(x: screenWidth / 2, y: 0)
                        Spacer()
                    }
            }).navigationBarTitle(Text("Salary Dashboard"))
            Spacer()
        }
    }
}

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    @Binding var placeholder: SearchByType

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        @Binding var placeholder: SearchByType

        init(text: Binding<String>, placeholder: Binding<SearchByType>) {
            _text = text
            _placeholder = placeholder
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, placeholder: $placeholder)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder.placehoderString
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        uiView.placeholder = placeholder.placehoderString
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
