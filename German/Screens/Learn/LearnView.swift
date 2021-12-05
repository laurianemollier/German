//
//  LearnView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import AVFoundation

struct LearnView: View {
    
    @StateObject var viewModel = LearnViewModel()
    @StateObject var searchBarViewModel = SearchBarViewModel()
    
    // TODO: ADD cancel + save
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Picker("Level Filter", selection: $viewModel.selectedLevel) {
                        Text("All level").tag(Level?.none)
                        ForEach(Level.allCases, id: \.self) { level in
                            Text(verbatim: "\(level)").tag(Level?.some(level))
                        }
                    }
                    
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
                    viewModel
                        .learningVerbs
                        .filter({ learningVerb in
                            if searchBarViewModel.isSearching {
                                return learningVerb.verb.temps.infinitive.value.lowercased()
                                    .contains(searchBarViewModel.searchText.lowercased())
                            } else {
                                return true
                            }
                        })
                        .filter({ learningVerb in
                            if let selectedForm = viewModel.selectedForm {
                                return learningVerb.verb.form == selectedForm
                            } else {
                                return true
                            }
                        })
                        .filter({ learningVerb in
                            if let selectedLevel = viewModel.selectedLevel {
                                return learningVerb.verb.level == selectedLevel
                            } else {
                                return true
                            }
                        })
                ) { learningVerb in
                    
//                    "Add the verb to the review list"
                    HStack {
                        VStack(alignment: .leading) {
                            Text.verbTemps(learningVerb.verb.temps.infinitive)
                                .font(.title2)
                                .fontWeight(.semibold)

                            Text.verbTemps(learningVerb.verb.temps.present)
                            Text.verbTemps(learningVerb.verb.temps.simplePast)
                            Text.verbTemps(learningVerb.verb.temps.pastParticiple)
                            
                            Spacer()
                            Text(learningVerb.verb.translation(Lang.en)).foregroundColor(Color.gray)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            
                            if learningVerb.userProgression == UserProgression.notSeenYet {
                                Button(action: {
                                    do{
                                        let success = try DAO.shared.addVerbToReviewList(learningVerb: learningVerb)
                                        if success {
                                            SpeedLog.print("Sucessly add verb to the review list")
                                            viewModel.loadData()
                                        }
                                        else{
                                            SpeedLog.print("One verb was not found")
                                        }
                                    }
                                    catch{
                                        SpeedLog.print(error)
                                    }
                                }, label: {
                                    ToChangeButton(
                                        title: "Add",
                                        backgroundColor: Color.green)
                                })
                            } else {
                                Button(action: {
                                    do{
                                        let success = try DAO.shared.removeVerbFromReviewList(learningVerb: learningVerb)
                                        if success {
                                            SpeedLog.print("Sucessly remove verb to the review list")
                                            viewModel.loadData()
                                        }
                                        else{
                                            SpeedLog.print("One verb was not found")
                                        }
                                    }
                                    catch{
                                        SpeedLog.print(error)
                                    }
                                }, label: {
                                    ToChangeButton(
                                        title: "Remove",
                                        backgroundColor: Color.red)
                                })
                            }
                        }
                    }.padding(20)
                }
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}
