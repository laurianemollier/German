//
//  VerbListView.swift
//  German
//
//  Created by Lauriane Mollier on 10/10/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct VerbListView: View {
    
    @EnvironmentObject var navigation: StatisticsNavigationModel
    
    // if not defined, load all the verbs
    let userProgression: UserProgression?
    @StateObject var viewModel = VerbListViewModel()
    @StateObject var searchBarViewModel = SearchBarViewModel()
    @State var cellViewMode: VerbListCellViewMode = VerbListCellViewMode.expanded
    
    var body: some View {
        VStack {
            HStack{
                Picker("Level Filter", selection: $viewModel.selectedLevel) {
                    Text("All level").tag(Level?.none)
                    ForEach(Level.allCases, id: \.self) { level in
                        Text(verbatim: "\(level)").tag(Level?.some(level))
                    }
                }
                
                Spacer()
                Picker("Level Form", selection: $viewModel.selectedForm) {
                    Text("All form").tag(Form?.none)
                    ForEach(Form.allCases, id: \.self) { form in
                        Text(verbatim: "\(form)").tag(Form?.some(form))
                    }
                }
                
                Spacer()
            }
         
            SearchBarView(viewModel: searchBarViewModel)
            
            List(
                viewModel.learningVerbs.filter({ learningVerb in
                    if searchBarViewModel.isSearching {
                        return learningVerb.verb.temps.infinitive.value.lowercased()
                            .contains(searchBarViewModel.searchText.lowercased())
                    } else {
                        return true
                    }
                })) { learningVerb in
                    NavigationLink(
                        tag: learningVerb,
                        selection: $navigation.activeLearningVerb,
                        destination: {
                            LearningVerbDetailsView(learningVerb: learningVerb)
                                .environmentObject(navigation) // TODO: should not be here
                        },
                        label: {
                            VerbListCell(verb: learningVerb.verb, viewMode: cellViewMode)
                        }
                    )
                }
        }.onAppear {
            viewModel.loadData(userProgression: userProgression)
        }
    }
}

struct VerbListView_Previews: PreviewProvider {
    static var previews: some View {
        VerbListView(userProgression: nil)
    }
}
