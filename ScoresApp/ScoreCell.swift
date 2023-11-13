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
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                HStack {
                    Text(score.yearS)
                    Spacer()
                    Text(score.lengthS)
                }
                .font(.caption)
                .padding(.top, 5)
            }
            if let new = ImageInteractor.shared.loadImage(id: score.id ){
                Image(uiImage: new)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(score.cover)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    ScoreCell(score: .test )
}
