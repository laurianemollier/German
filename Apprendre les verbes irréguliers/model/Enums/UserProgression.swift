//
//  UserProgression.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 14/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit

class Constants{
    static let secondsInOneDay = 86400
}


enum UserProgression: String {
    
    case notSeenYet = "notSeenYet"
    case level1 = "level1"
    case level2 = "level2"
    case level3 = "level3"
    case level4 = "level4"
    case level5 = "level5"
    case level6 = "level6"
    case level7 = "level7"
    case level8 = "level8"
    case toIgnore = "toIgnore"
    
    static let allValues = [notSeenYet, level1, level2 , level3, level4, level5, level6, level7, level8, toIgnore]
    
    
    func isInReviewList() -> Bool{
        return !self.isNotInReviewList()
    }
    func isNotInReviewList() -> Bool{
        return self == UserProgression.toIgnore || self == UserProgression.notSeenYet
    }
    
    func image() -> UIImage? {
        switch self { // TODO
        case UserProgression.level1:
            return #imageLiteral(resourceName: "UP Verypoor")
        case UserProgression.level2:
            return #imageLiteral(resourceName: "UP Poor")
        case UserProgression.level3:
            return #imageLiteral(resourceName: "UP Good")
        case UserProgression.level4:
            return #imageLiteral(resourceName: "UP Very Good")
        case UserProgression.level5:
            return #imageLiteral(resourceName: "UP Excelent")
        case UserProgression.level6:
            return #imageLiteral(resourceName: "UP Excelent")
        case UserProgression.level7:
            return #imageLiteral(resourceName: "UP Superb")
        case UserProgression.level8:
            return #imageLiteral(resourceName: "UP Fantastic")
        default:
            return nil
        }
        
    }
    
    
    func name() -> String? {
        switch self { // TODO
        case UserProgression.level1:
            return "Inexistant"
        case UserProgression.level2:
            return "Très faible"
        case UserProgression.level3:
            return "Faible"
        case UserProgression.level4:
            return "Assez bien"
        case UserProgression.level5:
            return "Bien"
        case UserProgression.level6:
            return "Très bien"
        case UserProgression.level7:
            return "Excelent"
        case UserProgression.level8:
            return "Optimal"
        case UserProgression.notSeenYet:
            return "Pas encore revu(s)"
        default:
            return nil
        }
    }
    
    // MARK: - Navigation between the progression level
    
    /// Give the information about the new level and the date to review a verb, when the user
    /// regress in the knowlege of this verb
    ///
    /// - Parameters:
    ///
    ///   - reviewedDate: The date one wich a verb has been reviewed
    ///
    /// - Returns:
    ///   - newProgression: The new progression level at wich the user is, if he regress of one level
    ///   - dateToReview: The new date at witch the verb has to be reviewed
    func regression(reviewedDate: Date) -> (newProgression: UserProgression, dateToReview: Date)? {
        return (UserProgression.level1, reviewedDate)
    }
    
    
    func stagnation(reviewedDate: Date) -> (newProgression: UserProgression, dateToReview: Date)?{
        switch self {
        case UserProgression.level1:
            let newDate = Date(timeInterval: TimeInterval(1 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level1, newDate)
        case UserProgression.level2:
            let newDate = Date(timeInterval: TimeInterval(2 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level2, newDate)
            
        case UserProgression.level3:
            let newDate = Date(timeInterval: TimeInterval(3 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level3, newDate)
            
        case UserProgression.level4:
            let newDate = Date(timeInterval: TimeInterval(5 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level4, newDate)
            
        case UserProgression.level5:
            let newDate = Date(timeInterval: TimeInterval(7 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level5, newDate)
            
        case UserProgression.level6:
            let newDate = Date(timeInterval: TimeInterval(14 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level6, newDate)
            
        case UserProgression.level7:
            let newDate = Date(timeInterval: TimeInterval(30 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level7, newDate)
            
        case UserProgression.level8:
            let newDate = Date(timeInterval: TimeInterval(90 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level8, newDate)
            
        default:
            return nil
        }
    }
    
    
    func progression(reviewedDate: Date) -> (newProgression: UserProgression, dateToReview: Date)? {
        switch self {
        case UserProgression.level1:
            let newDate = Date(timeInterval: TimeInterval(2 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level2, newDate)
            
        case UserProgression.level2:
            let newDate = Date(timeInterval: TimeInterval(3 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level3, newDate)
            
        case UserProgression.level3:
            let newDate = Date(timeInterval: TimeInterval(5 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level4, newDate)
            
        case UserProgression.level4:
            let newDate = Date(timeInterval: TimeInterval(7 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level5, newDate)
            
        case UserProgression.level5:
            let newDate = Date(timeInterval: TimeInterval(14 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level6, newDate)
            
        case UserProgression.level6:
            let newDate = Date(timeInterval: TimeInterval(30 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level7, newDate)
            
        case UserProgression.level7:
            let newDate = Date(timeInterval: TimeInterval(90 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level8, newDate)
        case UserProgression.level8:
            let newDate = Date(timeInterval: TimeInterval(365 * Constants.secondsInOneDay), since: Date())
            return (UserProgression.level8, newDate)
            
        default:
            return nil
        }
    }
    
    
    
    // MARK: - Name of navigation between the progression level
    
    
    func regressionName() -> String? {
        return "Maintenant" // TODO
    }
    
    
    func stagnationName() -> String?{
        switch self { // TODO
        case UserProgression.level1:
            return "Demain"
        case UserProgression.level2:
            return "Dans 2 jours"
        case UserProgression.level3:
            return "Dans 3 jours"
        case UserProgression.level4:
            return "Dans 5 jours"
        case UserProgression.level5:
            return "Dans 1 semaine"
        case UserProgression.level6:
            return "Dans 2 semaines"
        case UserProgression.level7:
            return "Dans 1 mois"
        case UserProgression.level8:
            return "Dans 3 mois"
            
        default:
            return nil
        }
    }
    
    
    func progressionName() -> String? {
        switch self { // TODO
        case UserProgression.level1:
            return "Dans 2 jours"
        case UserProgression.level2:
            return "Dans 3 jours"
        case UserProgression.level3:
            return "Dans 5 jours"
        case UserProgression.level4:
            return "Dans 1 semaine"
        case UserProgression.level5:
            return "Dans 2 semaines"
        case UserProgression.level6:
            return "Dans 1 mois"
        case UserProgression.level7:
            return "Dans 1 mois"
        case UserProgression.level8:
            return "Dans 1 an"
            
        default:
            return nil
        }
    }

}
