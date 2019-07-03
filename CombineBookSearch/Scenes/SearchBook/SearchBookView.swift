//
//  SearchBookView.swift
//  CombineBookSearch
//
//  Created by Pablo Paciello on 6/9/19.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import SwiftUI

struct SearchBookView : View {
    @ObjectBinding private var viewModel = SearchBookViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBookBar(text: viewModel[\.searchText])                
                List(viewModel.items) { item in
                    /*
                      FB6465137
                      For some reason using PresentationLink doesn't load the images in the SearchBookCell but only the text fields.
                      Using NavigationLink instead.
                     
                      PresentationLink(destination: BookDetail()) {
                          SearchBookCell(displayData: item)
                      }
                    */
                    NavigationLink(destination: BookDetail(displayData: item)) {
                        SearchBookCell(displayData: item)
                    }
                }
            }
            .navigationBarTitle(Text("Books Search"))
        }
    }
}

#if DEBUG
struct SearchBookView_Previews : PreviewProvider {
    static var previews: some View {
        SearchBookView()
    }
}
#endif
