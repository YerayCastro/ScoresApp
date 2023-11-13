//
//  Extensions.swift
//  ScoresApp
//
//  Created by Yery Castro on 13/11/23.
//

import SwiftUI

// Extension de UIImage, con la función de resize, para reescalar imágenes.
extension UIImage {
    func resize(width: CGFloat) -> UIImage? {
        let scale = width / self.size.width
        let height = self.size.height * scale
        return self.preparingThumbnail(of: CGSize(width: width, height: height))
    }
}
