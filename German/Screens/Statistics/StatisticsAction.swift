//
//  StatisticsAction.swift
//  German
//
//  Created by Lauriane Mollier on 09.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

enum StatisticsAction {
    case loadState
    case selectedVerbList(VerbListAction) // TODO: lolo clean
    case verbLists(id: UserProgression, action: VerbListAction) // TODO: lolo clean
    case setUserProgression(UserProgression?)
}

