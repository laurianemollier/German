//
//  VerbListView.swift
//  German
//
//  Created by Lauriane Mollier on 10/10/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct VerbListView: View {
    
    // if not defined, load all the verbs
    let userProgression: UserProgression?
    @StateObject var viewModel = VerbListViewModel()
    @StateObject var searchBarViewModel = SearchBarViewModel()
    
    var body: some View {
        
        // https://www.hackingwithswift.com/quick-start/swiftui/displaying-a-detail-screen-with-navigationlink
//        if let selected = viewModel.selectedLearningVerb {
//            NavigationLink(
//                destination: LearningVerbDetailsView(learningVerb: selected, isShowingDetail: $viewModel.isShowingDetail),
//                isActive: $viewModel.isShowingDetail) { EmptyView() }
//        }
    
        
        NavigationView{
            VStack {
//                if viewModel.isShowingDetail {
//                    NavigationLink(
//                        destination: LearningVerbDetailsView(learningVerb: viewModel.selectedLearningVerb!, isShowingDetail: $viewModel.isShowingDetail),
//                        isActive: $viewModel.isShowingDetail) { Text("sssssss") }
//                }
                
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
                        VerbListCell(verb: learningVerb.verb)
                            .onTapGesture {
                                viewModel.selectedLearningVerb = learningVerb
                            }
                    }
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
