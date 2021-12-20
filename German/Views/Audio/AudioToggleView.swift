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
    
    @ObservedObject var store: Store<AudioToggleState, AudioToggleAction>
    
    init(store: Store<AudioToggleState, AudioToggleAction>) {
        self.store = store
    }
    
    var body: some View {
        Button {
            store.send(.toggleAudio)
        } label: {
            if(store.value.audioEnable) {Text("🔔")}
            else {Text("🔕")}
        }
    }
}

struct AudioToggleView_Previews: PreviewProvider {
    static var previews: some View {
        AudioToggleView(store:
                            Store(
                                initialValue: AudioToggleState(),
                                reducer: AudioToggleReducer)
        )
    }
}
