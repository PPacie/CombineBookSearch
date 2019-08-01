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
    
    func fetchImage(completion: @escaping(UIImage?) -> Void) {
        guard let thumbURL = self.thumbnail else {
            return
        }
        
        //ApiService is supposed to return on the DispatchQueue.main
        _ = APIService.fetchImageData(imageUrl: thumbURL)
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .sink { image in
                completion(image)
            }
    }
}

