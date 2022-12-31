//
//  URLResponse+Extension.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 31/12/2022.
//

import Foundation

extension URLResponse {

    func validate() throws {

        guard let response = self as? HTTPURLResponse else { throw BreedsRequestError.unknownError }

        let statusCode = response.statusCode

        if statusCode == 200 { return }

        if statusCode == 429 { throw BreedsRequestError.tooManyRequests }

        throw BreedsRequestError.unknownError
    }
}
