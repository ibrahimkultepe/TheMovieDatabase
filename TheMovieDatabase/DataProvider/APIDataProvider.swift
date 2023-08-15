//
//  APIDataProvider.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

import Alamofire

struct APIDataProvider: DataProviderProtocol {
    
    private let interceptor: RequestInterceptor?
    private let session: Session
    
    init(interceptor: RequestInterceptor? = nil,
                eventMonitors: [EventMonitor] = []) {
        self.interceptor = interceptor
        self.session = Session(interceptor: interceptor, eventMonitors: eventMonitors)
        self.session.sessionConfiguration.timeoutIntervalForRequest = 20
    }
    
    private func createRequest<T: RequestProtocol>(_ request: T) -> DataRequest {
        let adapter = APIRequestAdapter(request: request)
        let request = session.request(adapter.url,
                                      method: adapter.method,
                                      parameters: adapter.parameters,
                                      encoding: adapter.encoding,
                                      headers: adapter.headers)
        return request
    }
    
     func request<T: DecodableResponseRequest>(for request: T, result: DataProviderResult<T.ResponseType>? = nil) {
        let request = createRequest(request)
        request.validate()
        request.responseDecodable(of: T.ResponseType.self) { (response) in
            switch response.result {
            case .success(let value):
                result?(.success(value))
            case .failure(let error):
                result?(.failure(error))
            }
        }
    }
}
