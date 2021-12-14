//
//  VerbListViewModel.swift
//  German
//
//  Created by Lauriane Mollier on 10/10/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class VerbListViewModel: ObservableObject {
    
    @Published var selectedLevel: Level? = nil
    @Published var selectedForm: Form? = nil
    @Published var learningVerbs: [LearningVerb] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    // if not defined, load all the verbs
    func loadData(userProgression: UserProgression?) {
        isLoading = true
        
        do {
            if let progression = userProgression {
                self.learningVerbs = try DAO.shared.select(userProgression: progression)
            } else {
                self.learningVerbs = try DAO.shared.all()
            }
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
