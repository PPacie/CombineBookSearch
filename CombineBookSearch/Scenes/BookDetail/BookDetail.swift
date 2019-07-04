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
        
        /*
            NOTE: Usually we would do something like the code below, but it seems that there is some sort of bug with dynamic content   and ScrollView in SwiftUI.
            ref: https://stackoverflow.com/questions/56826050/how-to-get-dynamic-text-height-for-a-scrollview-with-swiftui
 
        ScrollView {
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
                .edgesIgnoringSafeArea(.all)
            
            Text(self.displayData.title)
                .font(.title)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding()
            
            Text("Authors:")
                .font(.footnote)
                .fontWeight(.semibold)
            ForEach(self.displayData.authors.identified(by: \.self)) { author in
                Text(author)
                    .font(.footnote)
                    .lineLimit(nil)
            }
            
            Text(self.displayData.description)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding()
        }
        */
        
        //NOTE: This is a work aroud to the dynamic content issue. It doesn't work 100% though as it doesn't get the Text fully extended and truncates it at the bottom of the screen.
        GeometryReader { reader in
            ScrollView {
                ZStack(alignment: .top) {
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
                        
                        Text(self.displayData.title)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding()
                        
                        
                        Text("Authors:")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        ForEach(self.displayData.authors.identified(by: \.self)) { author in
                            Text(author)
                                .font(.footnote)
                                .lineLimit(nil)
                        }
                        
                        Text(self.displayData.description)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding()
                       
                        Spacer()
                    }
                }
                .frame(width: reader.size.width, height: reader.size.height)                
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
