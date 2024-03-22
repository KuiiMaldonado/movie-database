//
//  UIViewExtensions.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 25/02/23.
//

import UIKit

extension UIView {
    //MARK: - Methods
    func addRoundedCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
