//
//  RevisionViewModel.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class RevisionViewModel: ObservableObject {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
    /// The number of verb that is on the review list of this user
    @Published var verbInReviewListCount: Int?
    
    /// The number of verb that the user as to review today
    @Published var verbToReviewTodayCount: Int?
    
    /// Determine number of verb that the user will review in one review session
    @Published var nbrVerbInReviewSession = 10
    
    func loadData() {
        isLoading = true
        
        do {
            self.verbInReviewListCount = try DAO.shared.verbInReviewListCount()
            self.verbToReviewTodayCount = try DAO.shared.verbToReviewTodayCount()
            isLoading = false
        }
        catch {
            SpeedLog.print(error)
        }
        
        // TODO: lolo
        //        NetworkManager.shared.getAppetizers { [self] result in
        //            DispatchQueue.main.async {
        //                isLoading = false
        //                switch result {
        //                case .success(let appetizers):
        //                    self.appetizers = appetizers
        //
        //                case .failure(let error):
        //                    switch error {
        //                    case .invalidResponse:
        //                        alertItem = AlertContext.invalidResponse
        //
        //                    case .invalidURL:
        //                        alertItem = AlertContext.invalidURL
        //
        //                    case .invalidData:
        //                        alertItem = AlertContext.invalidData
        //
        //                    case .unableToComplete:
        //                        alertItem = AlertContext.unableToComplete
        //                    }
        //                }
        //            }
        //        }
        
    }
}
