//
//  BookDetail.swift
//  CombineBookSearch
//
//  Created by Pablo Paciello on 7/3/19.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import SwiftUI

struct BookDetail : View {
    private var displayData: BookDisplayData
    @State private var bookImage: UIImage? = nil
    private let placeholderImge = UIImage(named: "bookPlaceholder")!
    
    //This way we can force injection and keep displayData private.
    init(displayData: BookDisplayData) {
        self.displayData = displayData
    }
    
    var body: some View {
        
        VStack {
            Image(uiImage: self.bookImage ?? self.placeholderImge)
                .resizable()
                .onAppear {
                    self.displayData.fetchImage { image in
                        self.bookImage = image
                    }
                }
                .frame(width: 100, height: 150)
                .clipShape(Rectangle())
                .overlay(Rectangle()
                .stroke(Color.gray, lineWidth: 1))
            
            VStack {
                Text(self.displayData.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
            .padding()
            
            HStack {
                Text("Authors:")
                    .font(.footnote)
                    .fontWeight(.semibold)
                ForEach(self.displayData.authors.identified(by: \.self)) { e in
                    Text(e)
                        .font(.footnote)
                        .lineLimit(nil)
                }
            }
            .padding()
            
            Text(self.displayData.description)
                .lineLimit(nil)
                .padding()
            
            Spacer()
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
