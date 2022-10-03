//ResoneError.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
// Generics ResoneError when get resonse of api to show user it and undestant it
enum ResoneError :String,Error{
    case invaldURL               = "This URL invalid request."
    case invaldError             = "This URL Error Domain. Please check it and try again."
    case unableToComplete        = "Unable to complete your request. Please check your internet connection"
    case invalidResponse         = "Invalid response from the server. Please try again."
    case invalidData             = "The data received from the server was invalid. Please try again."
    case notFound                = "not found page"
   }

