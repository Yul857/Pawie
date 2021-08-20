//
//  TryLuckController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/19/21.
//

import UIKit

class TryLuckController: UIViewController {
    //MARK: - Properties
    private let diceArray: [UIImage] = [#imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "snake"), #imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "hamster"), #imageLiteral(resourceName: "fish"), #imageLiteral(resourceName: "rabbit")]
    
    private var randomOne: Int = 0
    private var randomTwo: Int = 0
    private var randomThree: Int = 0
    private var dailyChances: Int = 2
    
    private let headerImage: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "tryLuckHeaderPhoto")
        iv.setHeight(200)
        return iv
    }()
    
    private var diceOne: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.contentMode = .center
        iv.image = #imageLiteral(resourceName: "hamster")
        iv.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        iv.layer.borderWidth = 5
        iv.layer.cornerRadius = 10
        
        return iv
    }()
    
    private var diceTwo: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.contentMode = .center
        iv.image = #imageLiteral(resourceName: "hamster")
        iv.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        iv.layer.borderWidth = 5
        iv.layer.cornerRadius = 10
        iv.setDimensions(height: 120, width: 120)
        return iv
    }()
    
    private var diceThree: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.contentMode = .center
        iv.image = #imageLiteral(resourceName: "hamster")
        iv.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        iv.layer.borderWidth = 5
        iv.layer.cornerRadius = 10
        iv.setDimensions(height: 120, width: 120)
        return iv
    }()
    
    private let rollButton: UIButton = {
        let button = UIButton()
        button.setTitle("ROLL", for: .normal)
        button.addTarget(self, action: #selector(rollButtonPressed), for: .touchUpInside)
        button.layer.borderWidth = 3
        button.backgroundColor = .black
        button.setDimensions(height: 80, width: 160)
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.navigationItem.title = "TRY YOUR LUCK"
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(headerImage)
        headerImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        view.addSubview(diceOne)
        diceOne.centerX(inView: view, topAnchor: headerImage.bottomAnchor, paddingTop: 50)
        diceOne.setDimensions(height: 120, width: 120)
        
        let stack = UIStackView(arrangedSubviews: [diceTwo, diceThree])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        view.addSubview(stack)
        stack.anchor(top: diceOne.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 50, paddingRight: 50)
        view.addSubview(rollButton)
        rollButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 40)
    }
    
    //MARK: - Actions
    @objc func rollButtonPressed() {
        diceOne.animationImages = diceArray
        diceOne.animationDuration = 1.0
        diceOne.animationRepeatCount = 2
        diceOne.startAnimating()
        self.perform(#selector(afterDiceOnePressed), with: nil, afterDelay: diceOne.animationDuration)
        
        
        diceTwo.animationImages = diceArray
        diceTwo.animationDuration = 1.0
        diceTwo.animationRepeatCount = 2
        diceTwo.startAnimating()
        self.perform(#selector(afterDiceTwoPressed), with: nil, afterDelay: diceTwo.animationDuration)

        
        diceThree.animationImages = diceArray
        diceThree.animationDuration = 1.0
        diceThree.animationRepeatCount = 2
        diceThree.startAnimating()
        self.perform(#selector(afterDiceThreePressed), with: nil, afterDelay: diceThree.animationDuration)
        


        

    }
    
    @objc func afterDiceOnePressed() {
        diceOne.stopAnimating()
        let randomNumberOne = Int.random(in: 0...5)
        self.randomOne = randomNumberOne
        diceOne.image = diceArray[randomOne]
        print("Dice number one is \(randomOne)")
    }
    
    @objc func afterDiceTwoPressed() {
        diceTwo.stopAnimating()
        let randomNumberTwo = Int.random(in: 0...5)
        self.randomTwo = randomNumberTwo
        diceTwo.image = diceArray[randomTwo]
        print("Dice number two is \(randomTwo)")
    }
    
    @objc func afterDiceThreePressed() {
        diceThree.stopAnimating()
        let randomNumberThree = Int.random(in: 0...5)
        self.randomThree = randomNumberThree
        diceThree.image = diceArray[randomThree]
        print("Dice number three is \(randomThree)")
        checkIfHitJackpot()
    }
    
    
    func checkIfHitJackpot(){
        
        if dailyChances >= 0 {
            if randomOne == randomTwo && randomTwo == randomThree {
                print("Viola! YOU'VE HIT THE JACKPOT")
            }else if randomOne != randomTwo && randomTwo != randomThree && randomThree != randomOne {
                print("GOOD LUCK NEXT TIME")
            }else{
                print("YOU'VE WON A SMALL PRIZE")
            }
            dailyChances -= 1
            print(dailyChances)
        }else{
            rollButton.isEnabled = false
            rollButton.alpha = 0.5
        }
    }
}
