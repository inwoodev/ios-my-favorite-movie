//
//  String+Extension.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import Foundation

extension String {
    func convertToURL() throws -> URL {
        if let url = URL(string: self) {
            return url
        } else {
            throw NetworkError.invalidURL
        }
    }
    
    func htmlToString() -> String? {
        guard let data = self.data(using: .utf8) else {
            return ""
          }
            
          do {
              return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil).string
          } catch {
            return ""
          }
      }
}
