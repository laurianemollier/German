//
//  AudioToggleView.swift
//  German
//
//  Created by Lauriane Mollier on 10/16/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AudioToggleView: View {
    
    struct State: Equatable {
        let audioEnable: Bool
    }
    
    var store: Store<AudioToggleState, AudioToggleAction>
    @ObservedObject var viewStore: ViewStore<State, AudioToggleAction>
    
    public init(store: Store<AudioToggleState, AudioToggleAction>) {
        self.store = store
        self.viewStore = ViewStore(
            self.store
                .scope(state: State.init(audioToggleState:))
        )
    }
    
    var body: some View {
        Button {
            viewStore.send(.toggleAudio)
        } label: {
            if(viewStore.audioEnable) {Text("🔔")}
            else {Text("🔕")}
        }
    }
}

struct AudioToggleView_Previews: PreviewProvider {
    static var previews: some View {
        AudioToggleView(
            store:
                Store(
                    initialState: AudioToggleState(),
                    reducer: audioToggleReducer,
                    environment: ()
                )
        )
    }
}

extension AudioToggleView.State {
    init(audioToggleState state: AudioToggleState) {
        self.audioEnable = state.audioEnable
    }
}
