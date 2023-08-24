//
//  UIImageView+Extensions.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 22.08.2023.
//

import Kingfisher

public extension UIImageView {
    
    func setImage(_ urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        self.kf.setImage(with: url)
    }
}
