//
//  Item.swift
//  TechTest
//
//  Created by user on 18/6/18.
//  Copyright © 2018 SM. All rights reserved.
//

import Foundation

struct ItemCollection: Codable {
  let title: String = ""
  let rows : [Item] = [Item]()
}

struct Item: Codable {
  let title: String = ""
  let description: String = ""
  let imageHref: URL? = nil
}
