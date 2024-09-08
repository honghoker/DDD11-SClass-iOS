//
//  CheckListDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//


import Foundation

import CoreDomain

public struct CheckListDTO: Decodable {
  let checkboxes: [CheckListItemDTO]
}
