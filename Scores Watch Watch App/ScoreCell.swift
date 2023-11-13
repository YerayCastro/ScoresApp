//
//  ScoreCell.swift
//  ScoresApp
//
//  Created by Yery Castro on 9/11/23.
//

import SwiftUI

struct ScoreCell: View {
    let score: Score
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(score.title)
                    .font(.headline)
                Text(score.composer)
                    .font(.custom("Arial", size: 6))
                    .foregroundStyle(.secondary)
                HStack {
                    Text(score.yearS)
                    Spacer()
                    Text(score.lengthS)
                }
                .font(.custom("Arial", size: 6))
                .padding(.top, 5)
            }
            Image(score.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    ScoreCell(score: .test )
}
