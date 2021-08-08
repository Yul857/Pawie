//
//  RegisterController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/6/21.
//

import UIKit

class RegisterController: UIViewController {
    //MARK: - Properties
    private var viewModel = RegistrationViewModel()

    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePictureSelected), for: .touchUpInside)
        
        return button
    }()
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
       
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextfield: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private let fullNameTextField: CustomTextField = CustomTextField(placeholder: "Fullname")
    
    private let userNameTextField: CustomTextField = CustomTextField(placeholder: "Username")
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)

        return button
    }()
    
    
    //MARK: - Action
    @objc func handleShowLogIn(){
        navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
        print("tapped log in")
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField{
            viewModel.email = sender.text
        }else if sender == passwordTextfield{
            viewModel.password = sender.text
        }else if sender == fullNameTextField{
            viewModel.fullname = sender.text
        }else{
            viewModel.username = sender.text
        }

        updateForm()
    }
    
    @objc func handleProfilePictureSelected(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp(){
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextfield.text else{return}
        guard let fullname = fullNameTextField.text else{return}
        guard let username = userNameTextField.text?.lowercased() else{return}
        guard let profileImage = self.profileImage else {return}

        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.registerUser(withCredentials: credentials) { (error) in
            if let error = error{
                print("DEBUG: Failed to register, \(error)")
                return}
        }
        
        self.dismiss(animated: false, completion: nil)
//        self.delegate?.authenticationDidComplete()
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        //configureGradientLayer()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextfield, fullNameTextField, userNameTextField, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

}
//MARK: - UIImagePickerControllerDelegate

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else{ return }
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

//MARK: - FormViewModel

extension RegisterController: formViewModel{
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}
