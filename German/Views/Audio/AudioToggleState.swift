//
//  AudioToggleState.swift
//  German
//
//  Created by Lauriane Mollier on 19.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture
import AVFoundation

struct AudioToggleState {
    var audioEnable: Bool = Audio.shared.isOn()
    var audioPlayer: AVAudioPlayer?
    var playError: Error?
}
