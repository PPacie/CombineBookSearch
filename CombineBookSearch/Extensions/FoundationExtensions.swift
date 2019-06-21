import Foundation
import Combine

enum RequestError: Error {
    case request(code: Int, error: Error?)
    case cannotParse
    case unknown
}

extension URLSession {
    func send(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse, 200..<300 ~= httpResponse.statusCode {
                    return data
                }
                else if let httpResponse = httpResponse {
                    throw RequestError.request(code: httpResponse.statusCode, error: NSError(domain: httpResponse.description, code: httpResponse.statusCode, userInfo: httpResponse.allHeaderFields as? [String : Any]))
                }     else {
                    throw RequestError.unknown
                }
           
            }
            .eraseToAnyPublisher()
    }
}

    // - NOTE: `dataTask` method was replaced by new Combine `dataTaskPublisher`.
    //Leave it here just to compare old vs new methods.

//extension URLSession {
//    func send(request: URLRequest) -> AnyPublisher<Data, RequestError> {
//        AnyPublisher { subscriber in
//            #warning("TODO - Implement `dataTaskPublisher` when it gets released by Apple.")
//            let task = self.dataTask(with: request) { data, response, error in
//                DispatchQueue.main.async {
//                    let httpResponse = response as? HTTPURLResponse
//                    if let data = data, let httpResponse = httpResponse, 200..<300 ~= httpResponse.statusCode {
//                        _ = subscriber.receive(data)
//                        subscriber.receive(completion: .finished)
//                    }
//                    else if let httpResponse = httpResponse {
//                        subscriber.receive(completion: .failure(.request(code: httpResponse.statusCode, error: error)))
//                    }
//                    else {
//                        subscriber.receive(completion: .failure(.unknown))
//                    }
//                }
//            }
//
//            subscriber.receive(subscription: AnySubscription(task.cancel))
//            task.resume()
//        }
//    }
//}
    
//final class AnySubscription: Subscription {
//    private let cancellable: Cancellable
//
//    init(_ cancel: @escaping () -> Void) {
//        cancellable = AnyCancellable(cancel)
//    }
//
//    func request(_ demand: Subscribers.Demand) {}
//
//    func cancel() {
//        cancellable.cancel()
//    }
//}
