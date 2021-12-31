//
//  audioToggleReducer.swift
//  German
//
//  Created by Lauriane Mollier on 19.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture
import AVFoundation

let audioToggleReducer = Reducer<AudioToggleState, AudioToggleAction, ()> { state, action, environment in
    func audioStop(){
        if state.audioPlayer != nil && state.audioPlayer!.isPlaying{
            state.audioPlayer!.stop()
        }
    }
    
    switch action {
    case .toggleAudio:
        if(Audio.shared.isOn()){
            state.audioEnable = false
            Audio.shared.off()
            audioStop()
        }
        else{
            state.audioEnable = true
            Audio.shared.on()
        }
        return .none
        
    case .audioStop:
        audioStop()
        return .none
        
    case .audioPlay(verb: let verb, playVerbAudio: let playVerbAudio):
        if(Audio.shared.isOn()){ // TODO: audioEnable ?
            audioStop()
            let formatAudio = "mp3"
            let nameAudioFile: String
            
            switch playVerbAudio {
            case PlayVerbAudio.all:
                nameAudioFile = verb.temps.infinitive.value
            case PlayVerbAudio.infinitive:
                nameAudioFile = "\(verb.temps.infinitive.value)_infinitiv"
            case PlayVerbAudio.present:
                nameAudioFile = "\(verb.temps.infinitive.value)_praesent"
            case PlayVerbAudio.simplePast:
                nameAudioFile = "\(verb.temps.infinitive.value)_praeteritum"
            case PlayVerbAudio.pastParticiple:
                nameAudioFile = "\(verb.temps.infinitive.value)_perfekt"
            }
            
            do {
                if let path = Bundle.main.path(forResource: nameAudioFile, ofType: formatAudio) {
                    let audioURL = URL(fileURLWithPath: path)
                    state.audioPlayer = try AVAudioPlayer(contentsOf: audioURL, fileTypeHint: nil)
                    state.audioPlayer!.play()
                    state.audioPlayer!.numberOfLoops = 0
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                } else {
                    state.playError = CustomError.AudioFileNotFound(fileName: nameAudioFile)
                }
            } catch {
                state.playError = error
            }
        }
        return .none
    }
}
