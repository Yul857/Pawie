//
//  AddAdoptionController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/26/21.
//

import UIKit
import Firebase

class AddAdoptionController: UIViewController {
 
    
    private var profileImage: UIImage?
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePictureSelected), for: .touchUpInside)
        
        return button
    }()
    private let petNameTextField: CustomTextField = CustomTextField(placeholder: "Pet Name")
    
    private let breedTextField: CustomTextField = CustomTextField(placeholder: "breed")
    
    private let ageTextField: CustomTextField = CustomTextField(placeholder: "age of the pet")
    
    private let areaTextField: CustomTextField = CustomTextField(placeholder: "Area code")
    
    private let descriptionTextField: CustomTextField = CustomTextField(placeholder: "Please describe the pet")
    
    private let phoneTextField: CustomTextField = CustomTextField(placeholder: "Enter your phone number(optional)")
    private let emailTextField: CustomTextField = CustomTextField(placeholder: "Enter your Email address(optional)")
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add pet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleAddAdoption), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    //MARK: - Action
    
    func updateForm() {
        let petname = petNameTextField.text
        let breed = breedTextField.text
        let age = ageTextField.text
        let area = areaTextField.text
        let description = descriptionTextField.text
        if petname?.isEmpty == false && breed?.isEmpty == false
            && age?.isEmpty == false && area?.isEmpty == false  && description?.isEmpty == false{
            addButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            addButton.isEnabled = true
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
//        if sender == emailTextField{
//            viewModel.email = sender.text
//        }else if sender == passwordTextfield{
//            viewModel.password = sender.text
//        }else if sender == ownerNameTextField{
//            viewModel.ownername = sender.text
//        }else if sender == petNameTextField{
//            viewModel.petname = sender.text
//        }else if sender == userNameTextField {
//            viewModel.username = sender.text
//        }else{
//            viewModel.bio = sender.text
//        }
//
        updateForm()
    }
    
    
    @objc func handleProfilePictureSelected(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleAddAdoption(){
        guard let petName = petNameTextField.text else{return}
        guard let breed = breedTextField.text else{return}
        guard let age = ageTextField.text else{return}
        guard let area = areaTextField.text else {return}
        guard let description = descriptionTextField.text?.lowercased() else{return}
        let phone = phoneTextField.text ?? "phone unknown"
        let email = emailTextField.text ?? "Email unknown"
        guard let petImage = self.profileImage else {return}

        let credentials = AdoptionCredentials(petName: petName, breed: breed, age: age,
                                              area: area, description: description, phone: phone,
                                              email: email, petImage: petImage, time: Timestamp())
        AdoptionService.uploadAdoption(withCredentials: credentials) { error in
            if let  error = error {
                print("There is an error uploading adoption post \(error.localizedDescription)")
                return
            }else{
                self.navigationController?.popViewController(animated: false)
            }
        }
        
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Helpers

    
    func configureUI() {
        configurePinkGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 100, width: 100)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        let stack = UIStackView(arrangedSubviews: [petNameTextField, breedTextField, ageTextField, areaTextField, descriptionTextField, phoneTextField, emailTextField, addButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
    }
    
    func configureNotificationObservers() {
        petNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        breedTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        areaTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        descriptionTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

}
//MARK: - UIImagePickerControllerDelegate

extension AddAdoptionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else{ return }
        profileImage = selectedImage
        
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

