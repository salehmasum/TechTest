//
//  ItemService.swift
//  TechTest
//
//  Created by user on 18/6/18.
//  Copyright © 2018 SM. All rights reserved.
//

import Foundation
import Alamofire

class ItemService: LoadItemProtocol
{
  func loadItemListRequest(withCredentials payload: ItemListScene.ItemList.Request, completionHandler: @escaping (ItemCollection?, Error?) -> Void )
  {
    Alamofire.request(NetworkRouter.getItems).responseData { response in
      //
      debugPrint(response)
      switch response.result {
      case .success(let value):
        if let httpStatusCode = response.response?.statusCode {
          switch (httpStatusCode) {
          case 200..<300:
            do{
              let itemList = try JSONDecoder().decode(ItemCollection.self, from: value)
              completionHandler(itemList, nil)
            }catch(let error) {
              completionHandler(nil, error)
            }
          case 400..<500:
            completionHandler(nil, APIError.validationError(reason: "error description"))
          case 500..<600:
            completionHandler(nil, APIError.internalServerError)
          default:
            completionHandler(nil, APIError.serviceError)
          }
        }
      case .failure(let error):
        if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
          completionHandler(nil, APIError.noInternetConnectionError)
        }
        else {
          completionHandler(nil, APIError.networkError)
        }
      }
      //
    }
  }
}
