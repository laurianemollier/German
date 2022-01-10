//
//  StatisticsAction.swift
//  German
//
//  Created by Lauriane Mollier on 09.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//


enum StatisticsAction {
    case loadState
    case selectedVerbListDetails(VerbListAction)
    case storedVerbListDetails(id: UserProgression, VerbListAction)
    case setUserProgression(UserProgression?)
}

