//
//  FetchArticlesReponseDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/14/24.
//

import Foundation

public struct MainArticlesResponseDTO: Decodable {
  let articles: [MainArticleResponseDTO]
}
