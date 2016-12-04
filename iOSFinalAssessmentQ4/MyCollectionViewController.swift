//
//  MyCollectionViewController.swift
//  iOSFinalAssessmentQ4
//
//  Created by 洪德晟 on 2016/12/2.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit
import CoreMotion
import MessageUI

private let reuseIdentifier = "Cell"

class MyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {
    
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCollectionViewCell
        
        // Configure the cell
        cell.myView.layer.borderColor = UIColor.black.cgColor
        cell.myView.layer.borderWidth = 1
        switch indexPath.row {
        case 0 : cell.taskLabel.text = "顯示一個AlertView"
        case 1 : cell.taskLabel.text = "顯示藍色, 點擊變成紅色, 再次點擊變回藍色"
        cell.myView.backgroundColor = cell.selectCell ? UIColor.red : UIColor.blue
        case 2 : cell.taskLabel.text = "透過CoreMotion顯示使用者現在的步數, 並且即時更新"
        case 3 : cell.taskLabel.text = "開啟此APP在iOS設定的頁面"
        case 4 : cell.taskLabel.text = "打開Google Map或是web導航至ALPHAcamp"
        case 5 : cell.taskLabel.text = "開啟信箱並將標題填上\("測試信件")"
        default : cell.taskLabel.text = "nil"
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = CGSize(width: view.frame.width / 2, height: (view.frame.height - 16) / 3)
        
        return cellSize
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
        
        // for cell indexPath 0
        func alertCell() {
            let alert = UIAlertController(title: "🍎P P A P✏️", message: "I have a pen,\n I have an apple,\napplePen!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        // for cell indexPath 1
        func colorChange() {
            
            if cell.selectCell {
                cell.myView.backgroundColor = UIColor.blue
                cell.selectCell = false
            } else {
                cell.myView.backgroundColor = UIColor.red
                cell.selectCell = true
            }
        }
        
        // for cell indexPath 2
        func requestPedometerData() {
            
            cell.taskLabel.text = "0 steps"
            
            if(CMPedometer.isStepCountingAvailable()) {
                self.pedometer.startUpdates(from: Date()) {
                    (data, error) in
                    if error != nil {
                        print("There was an error requesting data from the pedometer: \(error?.localizedDescription)")
                    } else {
                        DispatchQueue.main.async {
                            if let data = data {
                                cell.taskLabel.text = "\(data.numberOfSteps) steps"
                                print("=======OK======")
                            }
                            print("=======INININ======")
                        }
                        print("=======IN======")
                    }
                    print("=======in func======")
                }
                print("==Pedometer Available==")
            } else {
                print("==Pedometer Not Available==")
                return
            }
        }
        
        // for cell indexPath 3
        func openAPPSetting() {
            let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString) as! URL
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
        
        // for cell indexPath 4
        func openGoogleMap() {
            let settingsUrl = NSURL(string:"comgooglemaps://?center=40.765819,-73.975866&zoom=14&views=traffic") as! URL
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            } else {
                NSLog("Can't use Google Maps")
            }
        }
        
        // for cell indexPath 5
        func sendMail() {
            // 1. Check Mail Box exist
            if  MFMailComposeViewController.canSendMail() {
                let mailController = MFMailComposeViewController()
                // 3. set mail title
                mailController.setSubject("測試信件")
                
                self.present(mailController, animated: true, completion: nil)
                mailController.mailComposeDelegate = self
                
            } else {
                let alert = UIAlertController(title: "你必須先要有個信箱", message: nil, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        switch indexPath.row {
        case 0 : alertCell()
        case 1 : colorChange()
        case 2 : requestPedometerData()
        case 3 : openAPPSetting()
        case 4 : openGoogleMap()
        case 5 : sendMail()
        default : return
        }
    }
    
    // For Mail Finished Action
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
