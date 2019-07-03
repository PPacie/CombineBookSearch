//
//  SearchBookBar.swift
//  CombineBookSearch
//
//  Created by Pablo Paciello on 6/9/19.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import SwiftUI

struct SearchBookBar : View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            Color.orange
            HStack {                
                TextField("type a book name...", text: $text)
                    .padding([.leading, .trailing], 8)
                    .frame(height: 32)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
                }
                  .padding([.leading, .trailing], 16)
            }
            .frame(height: 64)
    }

}

#if DEBUG
struct SearchBookBar_Previews : PreviewProvider {
    static var previews: some View {
        SearchBookBar(text: .constant(""))
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
