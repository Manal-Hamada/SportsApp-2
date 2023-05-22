
import Foundation

struct ExampleJson2KtSwift: Decodable  {

  var success : Int?      = nil
  var result  : [Result]? = []

  enum CodingKeys: String, CodingKey {

    case success = "success"
    case result  = "result"
  
  }



}
