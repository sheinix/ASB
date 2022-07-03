//
//  Errors.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation
// Defines the Errors:
// TODO: Proper error handling
enum Errors {
    case DI_ResolverError
    case NetworkRequestError
    
    var message: String {
        switch self {
        case .DI_ResolverError:
            return "Error Resolving Class"
        case .NetworkRequestError:
            return "NetworkRequest Error"
        }
    }
    
    var code: Int {
        switch self {
        case .DI_ResolverError: return 0001
        case .NetworkRequestError: return 0002
        }
    }
    
    // TODO: Proper error handling
    var error: Error {
        return NSError(domain: self.message, code: self.code, userInfo: [:])
    }
}
