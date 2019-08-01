//
//  SearchBookViewModel.swift
//  CombineBookSearch
//
//  Created by Pablo Paciello on 6/9/19.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import SwiftUI
import Combine

final class SearchBookViewModel: ObservableObject {    
    
    @Published var searchText = "" {
        willSet { objectWillChange.send() }
    }
    
    private (set) var items = [BookDisplayData]() {
        willSet { objectWillChange.send() }
    }
    
    private (set) var itemImages = [String: UIImage]() {
        willSet { objectWillChange.send() }
    }
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    init () {
        print("Init ViewModel")
        
        searchCancellable = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty && $0.first != " " }
            .flatMap { (searchString) -> AnyPublisher<[Book], Never> in
                print("searchString: \(searchString)")
                return APIService.searchBy(title: searchString)
                    .replaceError(with: []) //TODO: Handle Errors
                    .eraseToAnyPublisher()
            }
            .map {
                self.booksToBookDisplayData(books: $0)
            }
            .replaceError(with: []) //TODO: Handle Errors
            .assign(to: \.items, on: self)
    }

    private func booksToBookDisplayData(books: [Book]) -> [BookDisplayData]  {
        var displayDataItems = [BookDisplayData]()
        
        books.forEach {
            let displayData = BookDisplayData(id: $0.id, title: $0.volumeInfo?.title ?? "", authors: $0.volumeInfo?.authors ?? [], description: $0.volumeInfo?.description ?? "", thumbnail: $0.volumeInfo?.imageLinks?.thumbnail)
            displayDataItems.append(displayData)
        }
        return displayDataItems
    }
}

