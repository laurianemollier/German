import UIKit

/**
 This class is the first view controller that appears when we launch the app.
 From this view controller you can have access to all the functionnalities of the app.
 */
class MainBisVC: UIViewController {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    /// The number of verb that is on the review list of this user
    var nbrVerbInReviewList: Int!
    
    /// The number of verb that the user as to review today
    var nbrVerbToReviewToday: Int!
    
    
    // ------------------
    // MARK: - Outlets
    // ------------------
    
    /// The button that shows the **number of verb to review today** and leads to the revision session, ie. to the **ReviewVerbsVC** screen
    @IBOutlet weak var nbrVerbToReviewTodayButton: UIButton!
    
    /// The button that leads to the revision session, ie. to the **ReviewVerbsVC** screen
    @IBOutlet weak var reviewVerbs: BasicButton!
    
    /// The label that explains how many verb they is in the review list
    @IBOutlet weak var nbrVerbInReviewListLabel: UILabel!
    
    
    // ----------------------
    // MARK: - View overrides
    // ----------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If it is the first run of this app, set the database
        if FirstLaunch().isFirstLaunch {
            firstLaunchSetUp()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpData()
        textSetUp()
        functionalitiesSetUp()
    }
    
    override func viewDidLayoutSubviews() {
        self.reviewVerbs.layout()
    }
    
    // ------------------
    // MARK: - Private: SetUp this access to the database
    // ------------------
    
    
    /// Set the database needed for this screen or show the error if they is one by using a popup
    private func setUpData(){
        if Database.shared.successfulConnection{
            do{
                self.nbrVerbInReviewList = try DAO.shared.verbInReviewListCount()
                self.nbrVerbToReviewToday = try DAO.shared.verbToReviewTodayCount()
                
            }
            catch{
                SpeedLog.print(error)
                // TODO: To show the user that they is an error
            }
        }
        else {
            SpeedLog.print("DB shared connection failed")
            //            SpeedLog.print(Database.shared.error)
        }
    }
    
    /// Set the database on the first first launch or show the error if they is one by using a popup
    private func firstLaunchSetUp(){
        do{
            try SetUpDatabase.setUp()
        }
        catch{
            SpeedLog.print(error) // TODO: To show the user that they is an error by using a popup
        }
    }
    
    
    // ------------------
    // MARK: - Private: SetUp the screen
    // ------------------
    
    /// Set up the text that depending on data
    private func textSetUp(){
        self.nbrVerbToReviewTodayButton.setTitle(String(self.nbrVerbToReviewToday), for: .normal)
        self.nbrVerbInReviewListLabel.text = "verb(s) to review over " + String(self.nbrVerbInReviewList) + " in your review list"
    }
    
    // Disable the review session buttons if they is no verbs to review
    private func functionalitiesSetUp(){
        if self.nbrVerbToReviewToday == 0 {
            self.nbrVerbToReviewTodayButton.isEnabled = false
            self.reviewVerbs.isEnabled = false
        }
        else {
            self.nbrVerbToReviewTodayButton.isEnabled = true
            self.reviewVerbs.isEnabled = true
        }
    }
}
