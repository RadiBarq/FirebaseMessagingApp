//
//  SendMessageViewController.swift
//  pokemongotradcenterios
//
//  Created by Radi Barq on 12/30/16.
//  Copyright © 2016 Radi Barq. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class SendMessageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let inputTextField = UITextField()
    
    var messagesTexts = [String]()
    var messagesFrom = [String]()
    var messagesTimeStamps = [Float]()
    
    
    let userPhotoUrlRef = FIRDatabase.database().reference().child("Users").child(FirstViewController.messageTo_DisplayName).child("photoUrl")
    
    
    var userPhotoUrl: URL!
    
    var userPhoto: UIImage = UIImage()
    
    var notificationReference = FIRDatabase.database().reference().child("Users").child(FirstViewController.messageTo_DisplayName)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        
        navigationItem.title = FirstViewController.messageTo_DisplayName
        
        
        //  textFieldCp.addTarget(self, action: "addDoneButtonOnKeyboard", for: UIControlEvents.touchDown)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        
        
        //userPhotoUrl = (userPhotoUrlRef as! FIRDataSnapshot).value! as! URL
        
        
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        collectionView?.scrollIndicatorInsets = UIEdgeInsets (top: 8, left:  0, bottom: 50, right: 0)
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: "cellId")
        
        //setupInputComponents()
        
        
        
        collectionView?.keyboardDismissMode = .interactive
        
        setUpKeyboardObserver()
        observeMessages()
        
        // Building the cell
        
    }
    
    
    
    
    
    func setUpKeyboardObserver()
    {
        
        
    }
    
    
    func handleKeyBoardDidShow(notification: NSNotification)
    {
        let indexPath = NSIndexPath(item: self.messagesTexts.count - 1, section: 0)
        
        
        if self.messagesFrom.isEmpty == false
        {
            collectionView?.scrollToItem(at: indexPath as IndexPath, at: .top, animated: true)
        }
        
        
    }
    
    
    func handleKeyboardWillHideNotification(notification: NSNotification)
    {
        
        let keyBoardDuration = ((notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]) as! AnyObject).doubleValue
        
        
        
        containerViewBottomAnchor?.constant = 0
        
        
        UIView.animate(withDuration: keyBoardDuration!)
        {
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //  NotificationCenter.default.removeObserver(self)
        
    }
    
    
    lazy var inputContainterView: UIView =
        {
            let containerView = UIView()
            containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
            
            containerView.backgroundColor = UIColor.white
            
            
            // This code to add the button
            let sendButton = UIButton(type: .system)
            sendButton.setTitleColor(UIColor.orange, for: .normal)
            sendButton.setTitle("Send", for: .normal)
            sendButton.translatesAutoresizingMaskIntoConstraints = false
            
            sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
            
            
            containerView.addSubview(sendButton)
            
            //x,y,w,h
            sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
            sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
            
            
            self.inputTextField.textColor = UIColor.orange
            self.inputTextField.placeholder = "Enter message..."
            self.inputTextField.translatesAutoresizingMaskIntoConstraints = false
            
            
            
            // This code for the separator
            let seperatorLineView = UIView()
            seperatorLineView.backgroundColor = self.hexStringToUIColor(hex: "E6E6E6")
            seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(seperatorLineView)
            seperatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            seperatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            seperatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
            seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            
            
            containerView.addSubview(self.inputTextField)
            //x,y,w,h
            self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
            self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            self.inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
            self.inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
            
            
            let indexPath = NSIndexPath(item: self.messagesTexts.count - 1, section: 0)
            
            
            if self.messagesFrom.isEmpty == false
            {
                self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .top, animated: true)
            }
            
            
            
            return containerView
            
    }()
    
    
    //This for make the keyboard hiding when scrolling down fellow
    override var inputAccessoryView: UIView?
        {
        
        get
        {
            
            return inputContainterView
            
            
        }
        
        
    }
    
    
    override var canBecomeFirstResponder: Bool
        {
        
        get
        {
            return true
        }
    }
    
    
    
    func handleKeyboardWillShow(notification: NSNotification)
    {
        let keyBoardFrame = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]) as! AnyObject).cgRectValue
        
        
        let keyBoardDuration = ((notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]) as! AnyObject).doubleValue
        
        
        
        containerViewBottomAnchor?.constant = -keyBoardFrame!.height
        
        
        UIView.animate(withDuration: keyBoardDuration!)
        {
            
            self.view.layoutIfNeeded()
            
        }
        
        // move the input area up somehow???
    }
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    
    func setupInputComponents()
    {
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        
        //ios9 constraint anchors
        
        // x,y,w,h
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        containerViewBottomAnchor?.isActive = true
        
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        // This code to add the button
        let sendButton = UIButton(type: .system)
        sendButton.setTitleColor(UIColor.orange, for: .normal)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        
        
        containerView.addSubview(sendButton)
        
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        inputTextField.textColor = UIColor.orange
        inputTextField.placeholder = "Enter message..."
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        containerView.addSubview(inputTextField)
        //x,y,w,h
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        // This code for the separator
        let seperatorLineView = UIView()
        seperatorLineView.backgroundColor = hexStringToUIColor(hex: "E6E6E6")
        seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(seperatorLineView)
        seperatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    
    func handleSend()
    {
        
        let timestamp = Int(NSDate().timeIntervalSince1970)
        
        let ref = FIRDatabase.database().reference().child("Users").child(ThirdViewController.displayName).child("chat").child(FirstViewController.messageTo_DisplayName).childByAutoId().updateChildValues(["messageText": inputTextField.text, "messageFrom": ThirdViewController.displayName, "timestamp": timestamp])
        
        
        let ref2 = FIRDatabase.database().reference().child("Users").child(FirstViewController.messageTo_DisplayName).child("chat").child(ThirdViewController.displayName).childByAutoId().updateChildValues(["messageText": inputTextField.text, "messageFrom": ThirdViewController.displayName, "timestamp": timestamp])
        
        notificationReference.updateChildValues(["notified": true])
        
    }
    
    
    func observeMessages()
    {
        
        let ovserveReference = FIRDatabase.database().reference().child("Users").child(ThirdViewController.displayName).child("chat").child(FirstViewController.messageTo_DisplayName)
        
        
        
        ovserveReference.observe(.value, with: {snapshot in
            
            
            
            self.messagesTimeStamps = [Float]()
            self.messagesTexts =  [String]()
            self.messagesFrom = [String]()
            
            
            for messages in snapshot.children
            {
                
                
                for  message in (messages as! FIRDataSnapshot).children
                {
                    let childValue = String(describing: (message as! FIRDataSnapshot).value!) // Remeber this value maybe value.
                    
                    let childKey = String(describing: (message as! FIRDataSnapshot).key)
                    
                    
                    if childKey == "messageFrom"
                    {
                        self.messagesFrom.append(childValue)
                    }
                        
                    else if childKey == "messageText"
                    {
                        self.messagesTexts.append(childValue)
                    }
                        
                    else if childKey == "timestamp"
                    {
                        
                        self.messagesTimeStamps.append(Float(childValue)!)
                        
                    }
                }
            }
            
            print ("reload the data again")
            self.collectionView?.reloadData()
            
            self.inputTextField.text = nil
            
            let indexPath = NSIndexPath(item: self.messagesTexts.count - 1, section: 0)
            
            // scroll to the last index
            
            if self.messagesFrom.isEmpty == false
            {
                self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
            }
            
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messagesTexts.count
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ChatMessageCell
        
        
        let message = messagesTexts[indexPath.row]
        
        cell.textView.text = message
        
        //cell.backgroundColor = UIColor.orange
        
        //cell.profileImageView = userPhoto as! UIImageView
        
        if messagesFrom[indexPath.row] == ThirdViewController.displayName
        {
            // Will make the message orange
            cell.bubbleView.backgroundColor = UIColor.orange
            cell.textView.textColor = UIColor.white
            cell.profileImageView.isHidden = true
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: message).width + 32
        }
            
        else
        {
            // will make the message gray somehow.
            let color = hexStringToUIColor(hex: "E6E6E6")
            cell.textView.textColor = UIColor.black
            cell.profileImageView.isHidden = false
            cell.bubbleView.backgroundColor = color
            // This is to put the message to the right
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: message).width + 32
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        
        // get estimated height somehow??
        
        let text = messagesTexts[indexPath.row]
        
        height = estimateFrameForText(text: text).height + 20
        
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estimateFrameForText(text: String) -> CGRect
    {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if (!(parent?.isEqual(self.parent) ?? false)) {
            self.messagesTimeStamps = [Float]()
            self.messagesTexts =  [String]()
            self.messagesFrom = [String]()
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.messagesTimeStamps = [Float]()
        self.messagesTexts =  [String]()
        self.messagesFrom = [String]()
        
        
    }
    
    // public func imageFromServerURL(urlString: String) {
    
    //   URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
    
    //     if error != nil {
    //       print(error)
    //     return
    //}
    //DispatchQueue.main.async(execute: { () -> Void in
    //  let image = UIImage(data: data!)
    //self.userPhoto = image!
    //})
    
    //}).resume()
    // }}
}
