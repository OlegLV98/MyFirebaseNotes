//
//  AppColorSet.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit

struct AppColorSet {

    struct TabBar {
        static let title = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        static let backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let tintColor = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        static let unselectedItemTintColor = #colorLiteral(red: 0.6901960784, green: 0.7450980392, blue: 0.7725490196, alpha: 1)
    }
    
    struct SignUp {
        static let bgMainView = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let signUpView = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let signUpLabel = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let textFieldHeader = #colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.06666666667, alpha: 1)
        static let textFieldText = #colorLiteral(red: 0.6274509804, green: 0.6470588235, blue: 0.7294117647, alpha: 1)
        static let textField = #colorLiteral(red: 0.9411764706, green: 0.9607843137, blue: 0.9803921569, alpha: 1)
        static let eye = #colorLiteral(red: 0.7058823529, green: 0.7254901961, blue: 0.7921568627, alpha: 1)
        static let agreementLabel = #colorLiteral(red: 0.4941176471, green: 0.5411764706, blue: 0.5921568627, alpha: 1)
        static let checkmark = #colorLiteral(red: 0.8901960784, green: 0.9215686275, blue: 0.9490196078, alpha: 1)
        static let selectedCheckmark = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
        static let authButtonTitle = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let authButtonView = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        static let additionalQuestionLabel = #colorLiteral(red: 0.3921568627, green: 0.4117647059, blue: 0.5098039216, alpha: 1)
        static let authTextButtonTitle = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
    }
    
    struct SignIn {
        static let bgMainView = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let signInView = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let signInLabel = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let textFieldHeader = #colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.06666666667, alpha: 1)
        static let textFieldText = #colorLiteral(red: 0.6274509804, green: 0.6470588235, blue: 0.7294117647, alpha: 1)
        static let textField = #colorLiteral(red: 0.9411764706, green: 0.9607843137, blue: 0.9803921569, alpha: 1)
        static let passwordResetButton = #colorLiteral(red: 0.4941176471, green: 0.5411764706, blue: 0.5921568627, alpha: 1)
        static let authButtonTitle = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let authButtonView = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        static let additionalQuestionLabel = #colorLiteral(red: 0.3921568627, green: 0.4117647059, blue: 0.5098039216, alpha: 1)
        static let authTextButtonTitle = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
    }
    
    struct Home {
        static let bgMainView = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let addButton = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        static let table = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        struct FolderCell {
            static let separator = #colorLiteral(red: 0.6901960784, green: 0.7450980392, blue: 0.7725490196, alpha: 1)
            static let title = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let bgCell = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
            static let image = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        }
    }
    
    struct Notes {
        static let bgMainView = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let backButton = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        struct AddButton {
            static let plus = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let buttonBg = #colorLiteral(red: 0.6901960784, green: 0.7450980392, blue: 0.7725490196, alpha: 1)
        }
    }
    
    struct NoteCell {
        static let title = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let text = #colorLiteral(red: 0.6901960784, green: 0.7450980392, blue: 0.7725490196, alpha: 1)
        static let bgCell = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        static let star = #colorLiteral(red: 0.9226067066, green: 0.09683283418, blue: 0.2055897713, alpha: 1)
    }
    
    struct Settings {
        static let bgMainView = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let text = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        static let button = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        static let deleteText = #colorLiteral(red: 0.9226067066, green: 0.09683283418, blue: 0.2055897713, alpha: 1)
        static let deleteButton = #colorLiteral(red: 0.9226067066, green: 0.09683283418, blue: 0.2055897713, alpha: 1)
        static let backButton = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
    }
    
    struct CreatingNotes {
        static let bgMainView = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let backButton = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        struct TextField {
            static let text = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let fieldBg = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        }
        
        struct TextView {
            static let text = #colorLiteral(red: 0.6901960784, green: 0.7450980392, blue: 0.7725490196, alpha: 1)
            static let fieldBg = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        }
        
        static let loadImageButton = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        struct SaveButton {
            static let text = #colorLiteral(red: 0.6901960784, green: 0.7450980392, blue: 0.7725490196, alpha: 1)
            static let buttonBg = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        }
    }
    
    struct Favorite {
        static let bgMainView = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let title = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    struct Profile {
        static let bgMainView = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        static let image = #colorLiteral(red: 0.5294117647, green: 0.5294117647, blue: 0.5294117647, alpha: 1)
        static let nameLabel = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let emailLabel = #colorLiteral(red: 0.5294117647, green: 0.5294117647, blue: 0.5294117647, alpha: 1)
        static let datePicker = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        
        static let settingsButton = #colorLiteral(red: 0.5294117647, green: 0.5294117647, blue: 0.5294117647, alpha: 1)
        static let editButton = #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        
        static let singOutButtonTitle = #colorLiteral(red: 0.9226067066, green: 0.09683283418, blue: 0.2055897713, alpha: 1)
        static let singOutButtonBorder = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let bgSignOutButton = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        
        static let tableInfoEdit = #colorLiteral(red: 0.9226067066, green: 0.09683283418, blue: 0.2055897713, alpha: 1)
        static let tableDataEdit = #colorLiteral(red: 0.5294117647, green: 0.5294117647, blue: 0.5294117647, alpha: 1)
        static let tableInfo = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let tableData = #colorLiteral(red: 0.5294117647, green: 0.5294117647, blue: 0.5294117647, alpha: 1)
    }
}
