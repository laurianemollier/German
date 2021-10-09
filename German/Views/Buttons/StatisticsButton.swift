//
//  ProgressionButton.swift
//  German
//
//  Created by Lauriane Mollier on 10/5/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct StatisticsButton: View {
    
    var userProgression: UserProgression
    var verbCount: Int
    
    var body: some View {
        HStack{
            if let image = userProgression.image() {
                image.padding(.leading, 10)
            }
            
            Text(userProgression.name())
                .fontWeight(.bold)
                .padding(.leading, 10)
            
            Spacer()
            
            Text("\(verbCount) verb\(verbCount > 1 ? "s" : "")")
                .foregroundColor(.brandPrimary)
                .padding(.trailing, 10)
        }
        .frame(width: 260, height: 50)
        .foregroundColor(.white)
        .background(Color.gray)
        .cornerRadius(10)
    }
}

struct StatisticsButton_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsButton(userProgression: UserProgression.level1, verbCount: 1)
    }
}
