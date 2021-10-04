//
//  InnerView.swift
//  German
//
//  Created by Lauriane Mollier on 10/4/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

class UserProgress: ObservableObject {
    @Published var score = 0
}

struct InnerView: View {
    @ObservedObject var progress: UserProgress

    init(progress: UserProgress) {
        self.progress = progress
    }
    
    var body: some View {
        Button("Increase Score") {
            progress.score += 1
        }
    }
}

struct ContentView: View {
    @StateObject var progress = UserProgress()

    var body: some View {
        VStack {
            Text("Your score is \(progress.score)")
            InnerView(progress: progress)
        }
    }
}
