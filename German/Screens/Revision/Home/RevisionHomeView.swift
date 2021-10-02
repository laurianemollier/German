//
//  RevisionHomeView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct RevisionHomeView: View {
    @StateObject var viewModel = RevisionViewModel()
    @Binding var navigationState: RevisionNavigationState?
    
    var body: some View {
        ZStack{
                VStack {
                    CircularButton(action: {
                        self.navigationState = RevisionNavigationState.pickStyle
                    }, label: viewModel.verbToReviewTodayCount.map({String($0)}) ?? "--")
                    
                    Text("Verbs to review over \(viewModel.verbToReviewTodayCount.map({String($0)}) ?? "--") in your review list")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 60)
                    
                    Button {
                        self.navigationState = RevisionNavigationState.pickStyle
                    } label: {
                        CallToActionButton(title: "Review")
                    }
                    
                    Spacer()
                }
            .onAppear {
                viewModel.loadData()
            }
            
            if viewModel.isLoading {
                LoadingView()
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
        RevisionHomeView(navigationState: .constant(RevisionNavigationState.home))
    }
}

struct CircularButton: View {
    
    let action: () -> Void
    let label: String

    var body: some View {
        ZStack(alignment: .bottom){
            Circle()
                .frame(width: 190, height: 190)
                .foregroundColor(.red)
                .opacity(0.6)
            
            Button {
                action()
            } label: {
                Text(label)
                    .font(.largeTitle)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .background(Color.brandPrimary)
                    .clipShape(Circle())
            }
        }
    }
}
