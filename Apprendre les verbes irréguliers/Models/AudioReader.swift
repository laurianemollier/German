//
//  AudioReader.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 31/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import AVFoundation


class AudioReader{
    
    static let formatAudio = "mp3"

    
    static func play(verb: Verb){
        do {
            let nameAudioFile = verb.infinitive()
            let audioURL = URL(fileURLWithPath: Bundle.main.path(forResource: nameAudioFile, ofType: AudioReader.formatAudio)!)
            let audioPlayer = try! AVAudioPlayer(contentsOf: audioURL, fileTypeHint: nil)
            audioPlayer.play()
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            SpeedLog.print(error) // TODO
            // report for an error
        }
    }
    
    
    
}
