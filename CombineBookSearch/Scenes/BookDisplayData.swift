//
//  BookDisplayData.swift
//  CombineBookSearch
//
//  Created by Pablo Paciello on 6/9/19.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import Foundation
import SwiftUI

struct BookDisplayData: Identifiable {
    let id: String
    let title: String
    let authors: [String]
    let description: String
    let thumbnail: URL?
}
