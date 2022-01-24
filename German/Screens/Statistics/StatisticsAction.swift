//
//  StatisticsAction.swift
//  German
//
//  Created by Lauriane Mollier on 09.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

enum StatisticsAction {
    case loadState
    case selectedVerbList(VerbListAction)
    case verbLists(id: UserProgression, action: VerbListAction)
    case setUserProgression(UserProgression?)
}

