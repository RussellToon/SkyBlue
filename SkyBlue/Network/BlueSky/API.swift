//
//  API.swift
//  SkyBlue
//
//  Created by Russell Toon on 17/10/2024.
//


import Foundation
import OSLog


protocol API {
    func perform<T: Decodable>(path: String, query: [URLQueryItem]) async throws -> T
    //func perform<T: Decodable>(path: String) async throws -> T
}

extension API {
    func perform<T: Decodable>(path: String) async throws -> T {
        try await self.perform(path: path, query: [])
    }
}


struct BskyAPI: API {
    typealias Transport = (URLRequest) async throws -> (Data, URLResponse)

    var baseURL: URL
    var transport: Transport

    private let log = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: BskyAPI.self))


    init(
        baseURL: URL = URL(string: "https://public.api.bsky.app")!,
        transport:  @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)
    ) {
        self.baseURL = baseURL
        self.transport = transport
    }


    func perform<T: Decodable>(path: String, query: [URLQueryItem] = []) async throws -> T {

        let request = try buildRequest(
            path: path,
            query: query
        )

        let (data, urlResponse) = try await transport(request)

        //log.debug("API Result:\n\(String(decoding: data, as: UTF8.self) as NSString)")

        // TODO: Check urlResponse for http error code

        let result: T = try parseResult(jsonData: data)

        return result
    }


    private func parseResult<T: Decodable>(jsonData: Data) throws -> T {
        do {
            let result = try decoder.decode(T.self, from: jsonData)
            return result
        }
        catch {
            log.error("Parse error: \(error)")
            throw Error.decodeFailed(underlying: error)
        }
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let isoDateFormatter = Date.ISO8601FormatStyle()
        let isoDateFormatterFractionalSecs = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date: Date =
                try? isoDateFormatterFractionalSecs.parse(dateString) {
                return date
            }
            if let date: Date =
                try? isoDateFormatter.parse(dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Date string does not match expected format: \(dateString)"
            )
        })
        return decoder
    }

    private func buildRequest(
        path: String,
        query: [URLQueryItem] = [],
        method: Method = .get
    ) throws -> URLRequest {

        var url = baseURL.appending(path: path, directoryHint: .notDirectory)

        url.append(queryItems: query)

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }


    enum Method: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
    }

    enum Error: Swift.Error {
        case noConnection
        case timedOut(underlying: Swift.Error?)
        case transportFailed(underlying: Swift.Error?)
        case invalidResponse(response: URLResponse)
        case httpError(code: Int, message: String?)
        case createBodyFailed(underlying: Swift.Error?)
        case createUrlFailed(underlying: Swift.Error? = nil)
        case decodeFailed(underlying: Swift.Error?)
        case constructFailed(message: String)
    }
}

