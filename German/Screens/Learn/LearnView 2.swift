//
//  LearnView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import AVFoundation

struct LearnView: View {
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
//                NavigationLink(destination: Text("Second View"), tag: "Second", selection: $selection) { EmptyView() }
//                
//                NavigationLink(destination: Text("Third View"), tag: "Third", selection: $selection) { EmptyView() }
//                
//                Button("Tap to show second") {
//                    self.selection = "Second"
//                }
                
                Button {
                    do {
                        try DAO.shared.addRandomVerbToReviewList(ofLevel: [Level.A2], count: 10)
                    }
                    catch {
                        SpeedLog.print(error)
                    }
                    
                } label: {
                    ToChangeButton(
                        title: "Add randomly some verb",                        backgroundColor: Color.orange)
                }
            }
        }
    }
    
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
