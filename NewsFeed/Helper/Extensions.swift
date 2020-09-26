//
//  Date+Relative.swift
//  DailyFeed
//
//  Created by LittleBiteOfCocoa on 24/09/20.
//  Copyright © littlebitesofcocoa.com. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var dateFromTimestamp: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: self)
        return date
    }
    
    var languageStringFromISOCode: String {
        let locale = Locale.current
        guard let languageString = locale.localizedString(forLanguageCode: self) else { return self }
        return languageString
    }
    
    var formattedCountryDescription: String {
        return countryFlagFromCountryCode + " " + countryStringFromCountryCode
    }
    
    var countryStringFromCountryCode: String {
        let locale = Locale.current
        guard let languageString = locale.localizedString(forRegionCode: self) else { return self }
        return languageString
    }
    
    var countryFlagFromCountryCode: String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
    
    var direction: Locale.LanguageDirection {
        return NSLocale.characterDirection(forLanguage: self)
    }
}



extension UIImageView {
    
    /// Function to add Gradient.
    /// - Parameters:
    ///   - color: Passing in color.
    ///   - locations: passing in location coordinates for creating gradients.
    func addGradient(_ color: [CGColor], locations: [NSNumber]) {

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.superview!.frame
        gradient.colors = color
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
}
