//
//  State.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation

 // State  say me what viewmodel do it do loading activityIndicator or show error 
public enum State {
    case loading
    case error
    case empty
    case populated
}
