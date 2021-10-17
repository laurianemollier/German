//
//  AudioToogleView.swift
//  German
//
//  Created by Lauriane Mollier on 10/16/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct AudioToggleView: View {
    
    @EnvironmentObject var viewModel: AudioToggleViewModel
    
    var body: some View {
        Button {
            viewModel.toggleAudio()
        } label: {
            if(viewModel.isOn()) {Text("🔔")}
            else {Text("🔕")}
        }
    }
}

struct AudioToogleView_Previews: PreviewProvider {
    static var previews: some View {
        AudioToggleView()
    }
}
