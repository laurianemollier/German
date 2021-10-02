//
//  LearnView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct LearnView: View {
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Second View"), tag: "Second", selection: $selection) { EmptyView() }
                
                NavigationLink(destination: Text("Third View"), tag: "Third", selection: $selection) { EmptyView() }
                
                Button("Tap to show second") {
                    self.selection = "Second"
                }
                Button("Tap to show third") {
                    self.selection = "Third"
                }
            }
            .navigationTitle("Navigation")
        }
//        .navigationTitle("Navigation")
//        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
