//
//  SearchBookCell.swift
//  CombineBookSearch
//
//  Created by Pablo Paciello on 6/9/19.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import SwiftUI

struct SearchBookCell: View {
    private var displayData: BookDisplayData
    @State private var bookImage: UIImage? = nil
    private let placeholderImge = UIImage(named: "bookPlaceholder")!
    
    //This way we can force injection and keep displayData private.
    init(displayData: BookDisplayData) {
        self.displayData = displayData
    }
    
    var body: some View {
        HStack {
            Image(uiImage: bookImage ?? placeholderImge)
                .resizable()
                .onAppear {
                    self.displayData.fetchImage { image in
                        self.bookImage = image
                    }
                }
                .frame(width: 50, height: 65)
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text(displayData.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack {
                    Text("Authors:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    ForEach(displayData.authors.identified(by: \.self)) { e in
                        Text(e)
                            .font(.footnote)
                    }
                }
            }

            Spacer()
        }
        .frame(height: 65)
    }
}

#if DEBUG
let bookDemoData = BookDisplayData(id: "1234", title: "Demo Book Demo Book Demo Book Demo Book Demo Book", authors: ["Pepe","Chuello"], description: "BookDescription", thumbnail: URL(string:"bookDemo")!)

struct SearchBookCell_Previews : PreviewProvider {
    static var previews: some View {
        SearchBookCell(displayData: bookDemoData)
            .previewLayout(.fixed(width: 300, height: 65))
            .previewDisplayName("SearchBookCell")
    }
}
#endif
