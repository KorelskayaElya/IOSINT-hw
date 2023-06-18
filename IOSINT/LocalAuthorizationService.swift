//
//  LocalAuthorizationService.swift
//  IOSINT
//
//  Created by Эля Корельская on 18.06.2023.
//

import UIKit
import LocalAuthentication

enum BiometricType {
    case none
    case touch
    case face
}

class LocalAuthorizationService {
    
    let context = LAContext()
    let policy: LAPolicy = .deviceOwnerAuthentication
    var error: NSError?
    var canUseBiometrics = false
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        
        canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
        if let error = error {
            switch error {
            case LAError.biometryNotAvailable:
                TemplateErrorAlert.shared.alert(alertTitle: error.localizedDescription, alertMessage: "")
                authorizationFinished(false)
            default:
                authorizationFinished(false)
            }
        }
        guard canUseBiometrics else {
            return
        }
        context.evaluatePolicy(policy, localizedReason: "Авторизуйтесь") { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    switch error {
                    case LAError.userCancel, LAError.authenticationFailed, LAError.appCancel, LAError.biometryLockout, LAError.biometryNotEnrolled, LAError.systemCancel:
                        TemplateErrorAlert.shared.alert(alertTitle: error.localizedDescription, alertMessage: "")
                        authorizationFinished(false)
                    default:
                        authorizationFinished(false)
                    }
                }
                authorizationFinished(true)
            }
        }
    }
    func checkBiometryType() -> BiometricType {
        if #available(iOS 11, *) {
            let _ = context.canEvaluatePolicy(policy, error: nil)
            switch(context.biometryType) {
            case .touchID:
                return .touch
            case .faceID:
                return .face
            default:
                return .none
            }
        } else {
            return context.canEvaluatePolicy(policy, error: nil) ? .touch : .none
        }
}
}

