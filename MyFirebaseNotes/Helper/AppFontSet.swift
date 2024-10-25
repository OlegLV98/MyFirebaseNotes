//
//  AppFontSet.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

struct AppFontSet {
    struct SignUp {
        static let signUpLabel = UIFont(name: "Sen-Bold", size: 34.4) ?? UIFont.systemFont(ofSize: 34.4)
        static let textFieldHeader = UIFont(name: "Sen-Regular", size: 14.91) ?? UIFont.systemFont(ofSize: 14.91)
        static let textFieldText = UIFont(name: "Sen-Regular", size: 16.05) ?? UIFont.systemFont(ofSize: 16.05)
        static let agreementLabel = UIFont(name: "Sen-Regular", size: 13.76) ?? UIFont.systemFont(ofSize: 13.76)
        static let authButtonTitle = UIFont(name: "Sen-Bold", size: 16.05) ?? UIFont.systemFont(ofSize: 16.05)
        static let additionalQuestionLabel = UIFont(name: "Sen-Regular", size: 18.35) ?? UIFont.systemFont(ofSize: 18.35)
        static let authTextButtonTitle = UIFont(name: "Sen-Bold", size: 16.05) ?? UIFont.systemFont(ofSize: 16.05)
    }
    
    struct SignIn {
        static let signInLabel = UIFont(name: "Sen-Bold", size: 34.4) ?? UIFont.systemFont(ofSize: 34.4)
        static let textFieldHeader = UIFont(name: "Sen-Regular", size: 14.91) ?? UIFont.systemFont(ofSize: 14.91)
        static let textFieldText = UIFont(name: "Sen-Regular", size: 16.05) ?? UIFont.systemFont(ofSize: 16.05)
        static let authButtonTitle = UIFont(name: "Sen-Bold", size: 16.05) ?? UIFont.systemFont(ofSize: 16.05)
        static let passwordResetButton = UIFont(name: "Sen-Regular", size: 16.05) ?? UIFont.systemFont(ofSize: 16.05)
        static let additionalQuestionLabel = UIFont(name: "Sen-Regular", size: 18.35) ?? UIFont.systemFont(ofSize: 18.35)
        static let authTextButtonTitle = UIFont(name: "Sen-Bold", size: 16.05) ?? UIFont.systemFont(ofSize: 16.05)
    }
    
    struct Profile {
        static let nameLabel = UIFont(name: "Sen-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)
        static let emailLabel = UIFont(name: "Inter-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
        static let authButtonTitle = UIFont(name: "Inter-SemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }
}
