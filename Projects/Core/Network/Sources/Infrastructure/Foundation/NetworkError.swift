//
//  NetworkError.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

import Moya

enum NetworkError: Error {
  case underlying(MoyaError)
  case invalidResponse(statusCode: Int, message: String)
  case noData
  case decodingError(Error)
}
