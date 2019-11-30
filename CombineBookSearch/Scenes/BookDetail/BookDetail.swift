//
//  BookDetail.swift
//  CombineBookSearch
//
//  Created by Pablo Paciello on 7/3/19.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import SwiftUI

struct BookDetail : View {
    @State private var bookImage: UIImage? = nil
    private let placeholderImge = UIImage(named: "bookPlaceholder")!
    private let displayData: BookDisplayData
    
    init(displayData: BookDisplayData) {
        self.displayData = displayData
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    
                    Image(uiImage: self.bookImage ?? self.placeholderImge)
                        .resizable()
                        .onAppear {
                            self.displayData.fetchImage { image in
                                self.bookImage = image
                            }
                    }
                    .frame(width: 100, height: 150)
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                    
                    Spacer()
                }
                
                Text(self.displayData.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()
                
                if self.displayData.authors.first != nil {
                    Text("Authors:")
                    .font(.footnote).fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(0)
                    
                    ForEach(self.displayData.authors, id: \.self) { author in
                        Text(author)
                            .multilineTextAlignment(.center)
                            .font(.footnote)
                            .lineLimit(1)
                            .padding(1)
                    }
                }                
                
                Text(self.displayData.description)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()
            }
        }
    }
}

#if DEBUG
struct BookDetail_Previews : PreviewProvider {
    static var previews: some View {
        BookDetail(displayData: bookDemoData)
    }
}
#endif
