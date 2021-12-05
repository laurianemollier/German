//
//  RevisionHomeView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct RevisionHomeView: View {
    
    @EnvironmentObject var navigation: RevisionNavigationModel
    
    @StateObject var viewModel = RevisionHomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    NavigationLink(
                        destination: ReviewVerbView(),
                        isActive: $navigation.activeRevision,
                        label: {
                            ZStack(alignment: .bottom){
                                Circle()
                                    .frame(width: 190, height: 190)
                                    .foregroundColor(.red)
                                    .opacity(0.6)
                                
                                Text(
                                    viewModel
                                        .verbToReviewTodayCount
                                        .map({String($0)}) ?? "--"
                                )
                                    .font(.largeTitle)
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.white)
                                    .background(Color.brandPrimary)
                                    .clipShape(Circle())
                                
                            }
                        })
                        .disabled(viewModel.isRevisionDisabled)
                    
                    Text("Verbs to review over \(viewModel.verbInReviewListCount.map({String($0)}) ?? "--") in your review list")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 60)
                    
                    NavigationLink(
                        destination: ReviewVerbView(),
                        isActive: $navigation.activeRevision,
                        label: {CallToActionButton(title: "Review")}
                    ).disabled(viewModel.isRevisionDisabled)
                    
                    Spacer()
                }
                .onAppear() {
                    viewModel.loadData()
                }
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

struct RevisionHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RevisionHomeView()
    }
}
