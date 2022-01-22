//
//  StatisticsAction.swift
//  German
//
//  Created by Lauriane Mollier on 09.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

//enum StatisticsAction {
//    case loadState
//    case verbList(id: VerbListState.ID, action: VerbListAction)
//}

enum StatisticsAction {
    case loadState
    case selectedVerbListDetails(VerbListAction) // TODO: lolo clean
    case storedVerbListDetails(id: UserProgression, VerbListAction) // TODO: lolo clean
    case setUserProgression(UserProgression?)
}

