//
//  Place.swift
//  UI-240
//
//  Created by にゃんにゃん丸 on 2021/06/18.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    var id = UUID().uuidString
    var placemark : CLPlacemark
}

