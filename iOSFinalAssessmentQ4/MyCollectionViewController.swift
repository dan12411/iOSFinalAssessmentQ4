//
//  MyCollectionViewController.swift
//  iOSFinalAssessmentQ4
//
//  Created by 洪德晟 on 2016/12/2.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit
import CoreMotion

private let reuseIdentifier = "Cell"

class MyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
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
            let alert = UIAlertController(title: "🍎P P A P✏️", message: "I have an apple,\n I have a pen,\napplePen!", preferredStyle: .alert)
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
        
        switch indexPath.row {
        case 0 : alertCell()
        case 1 : colorChange()
        case 2 : requestPedometerData()
        case 3 : return
        case 4 : return
        case 5 : return
        default : return
        }
    }
    
    
    /*
     // Uncƒomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
