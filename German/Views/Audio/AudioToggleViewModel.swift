//
//  AudioToggleViewModel.swift
//  German
//
//  Created by Lauriane Mollier on 10/16/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import AVFoundation

final class AudioToggleViewModel: ObservableObject {
    
    @Published var audioEnable: Bool
    private var audioPlayer: AVAudioPlayer?
    
    // ------------
    // MARK: - Init
    // ------------
    
    init() {
        self.audioEnable = Audio.shared.isOn()
    }
    
    func isOn() -> Bool {
        Audio.shared.isOn()
    }
    
    func toggleAudio() {
        if(Audio.shared.isOn()){
            audioEnable = false
            Audio.shared.off()
            audioStop()
        }
        else{
            audioEnable = true
            Audio.shared.on()
        }
    }
    
    func audioPlay(verb: Verb, playVerbAudio: PlayVerbAudio) throws {
        if(Audio.shared.isOn()){
            audioStop()
            let formatAudio = "mp3"
            let nameAudioFile: String
            
            switch playVerbAudio {
            case PlayVerbAudio.all:
                nameAudioFile = verb.temps.infinitive.value
            case PlayVerbAudio.infinitive:
                nameAudioFile = verb.temps.infinitive.value // TODO: lolo
            case PlayVerbAudio.present:
                nameAudioFile = verb.temps.infinitive.value // TODO: lolo
            case PlayVerbAudio.simplePast:
                nameAudioFile = verb.temps.infinitive.value // TODO: lolo
            case PlayVerbAudio.pastParticiple:
                nameAudioFile = verb.temps.infinitive.value // TODO: lolo
            }
            
            let audioURL = URL(fileURLWithPath: Bundle.main.path(forResource: nameAudioFile, ofType: formatAudio)!)
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL, fileTypeHint: nil)
            audioPlayer!.play()
            audioPlayer!.numberOfLoops = 0
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
    }
    
    func audioStop(){
        if audioPlayer != nil && audioPlayer!.isPlaying{
            audioPlayer!.stop()
        }
    }
}
