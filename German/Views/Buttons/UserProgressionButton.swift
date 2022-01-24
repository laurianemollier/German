//
//  ProgressionButton.swift
//  German
//
//  Created by Lauriane Mollier on 10/5/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct UserProgressionButton: View {
    
    var isLoading: Bool
    var isSelected: Bool
    var userProgression: UserProgression
    var verbCount: Int?
    
    var body: some View {
        HStack{
            if let image = userProgression.image() {
                image.padding(.leading, 10)
            }
            
            Text(userProgression.name())
                .fontWeight(.bold)
                .padding(.leading, 10)
            
            Spacer()
            
            if(isLoading) {  ProgressView() }
            else if let count = verbCount {
                Text("\(count) verb\(count > 1 ? "s" : "")")
                    .foregroundColor(.brandPrimary)
                    .padding(.trailing, 10)
            }
        }
        .frame(width: 260, height: 50)
        .foregroundColor(.white)
        .background(isSelected ? .blue : .gray)
        .cornerRadius(10)
    }
}

struct StatisticsButton_Previews: PreviewProvider {
    static var previews: some View {
        UserProgressionButton(isLoading: false, isSelected: false, userProgression: UserProgression.level1, verbCount: 2)
    }
}
