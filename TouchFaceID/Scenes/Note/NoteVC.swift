//
//  NoteVC.swift
//  TouchFaceID
//
//  Created by Mahmoud Sherbeny on 04/10/2021.
//

import UIKit
import LocalAuthentication

class NoteVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var lblTestStatus: UILabel!
    
    // MARK: - VC lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction functions
    @IBAction func testButtonTapped(_ sender: UIButton) {
        self.authenticationBiometrics { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.lblTestStatus.text = status ? "Auth Success" : "Auth Failed"
            }
        }
    }
    
}

// MARK: - Helper Extension
extension NoteVC {
    private func authenticationBiometrics(callBack: @escaping (Bool) -> Void) {
        let myContext = LAContext()
        let myLocalizedReasonString = "Our app uses Touch / Face ID for secure goal"
        var authError: NSError?
        
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, error in
                if success {
                    callBack(true)
                } else {
                    guard let evaluateErrorString = error?.localizedDescription else { return }
                    self.showErrorMassage(withMessage: evaluateErrorString)
                    callBack(false)
                }
            }
        } else {
            guard let evaluateErrorString = authError?.localizedDescription else { return }
            self.showErrorMassage(withMessage: evaluateErrorString)
            callBack(false)
        }
    }

    private func showErrorMassage(withMessage message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
