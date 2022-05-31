//
//  TestViewController.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 4/12/22.
//

import UIKit

class TestViewController: UIViewController{
    
    @IBOutlet weak var progressBar: ProgressBar!
    
    
    var countFired: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.countFired += 1
            
            DispatchQueue.main.async {
                self.progressBar.progress = min(0.03 * self.countFired, 1)
                
                if self.progressBar.progress == 1{
                    timer.invalidate()
                    
                }
            }
        }
        
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    
        
    

}
