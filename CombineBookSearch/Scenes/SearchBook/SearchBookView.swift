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
                    SearchBookCell(displayData: item)
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
