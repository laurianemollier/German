import UIKit

/**
 This class is the first view controller that appears when we launch the app.
 From this view controller you can have access to all the functionnalities of the app.
 */
class Review2VC: UIViewController {
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
