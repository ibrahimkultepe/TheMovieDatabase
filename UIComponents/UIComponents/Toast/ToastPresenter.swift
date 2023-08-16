//
//  ToastPresenter.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

import SwiftEntryKit

public class ToastPresenter {
    
    public static func showWarningToast(text: String) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: EKColor(light: .red, dark: .red))
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        
        let customView = TostWarningView(text: text)
        SwiftEntryKit.display(entry: customView, using: attributes)
    }
    
    public static func showSuccessToast(text: String) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: EKColor(light: .green, dark: .green))
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        
        let customView = TostSuccessView(text: text)
        SwiftEntryKit.display(entry: customView, using: attributes)
    }
}
