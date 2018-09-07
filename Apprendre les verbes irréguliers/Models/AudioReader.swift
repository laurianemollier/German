//
//  AudioReader.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 31/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import AVFoundation


class AudioReader{
    
    static let formatAudio = "mp3"

    
    static func play(verb: Verb){
        do {
            let nameAudioFile = verb.infinitive()
            let audioURL = URL(fileURLWithPath: Bundle.main.path(forResource: nameAudioFile, ofType: AudioReader.formatAudio)!)
            let audioPlayer = try! AVAudioPlayer(contentsOf: audioURL)
//            try! AVAudioPlayer(contentsOf: audioURL, fileTypeHint: nil)
//            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = 1
            audioPlayer.play()
            
            SpeedLog.print("Allez!!!!!")
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            SpeedLog.print("Voila")
        }
        catch {
            SpeedLog.print("error")
            SpeedLog.print(error) // TODO
            // report for an error
        }
    }
    
    
    
}
