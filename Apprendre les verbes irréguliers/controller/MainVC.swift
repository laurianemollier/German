import UIKit

/**
 This class is the first view controller that appears when we launch the app.
 From this view controller you can have access to all the functionnalities of the app.
 */
class MainVC: UIViewController {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    /// The number of verb that is on the review list of this user
    var nbrVerbInReviewList: Int!
    
    /// The number of verb that the user as to review today
    var nbrVerbToReviewToday: Int!
    
    /// Determine number of verb that the user will review in one review session
    var nbrVerbInReviewSession = 10 // TODO: make a variable
    
    
    // ------------------
    // MARK: - Outlets
    // ------------------
    
    /// The button that shows the **number of verb to review today** and leads to the revision session, ie. to the **ReviewVerbsVC** screen
    @IBOutlet weak var nbrVerbToReviewTodayButton: UIButton!
    
    /// The button that leads to the revision session, ie. to the **ReviewVerbsVC** screen
    @IBOutlet weak var reviewVerbs: BasicButton!
    
    /// The label that explains how many verb they is in the review list
    @IBOutlet weak var nbrVerbInReviewListLabel: UILabel!
    
    
    /// The button that leads to A the **AddVerbsVC** screen
    @IBOutlet weak var addVerbsButton: BasicButton!
    
    /// The button that leads to A the **ListVerbsVC** screen
    @IBOutlet weak var seeAllVerbsButton: BasicButton!
    
    /// The button that leads to A the **StatisticsVC** screen
    @IBOutlet weak var yourStatisticsButton: BasicButton!
    
    
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
        self.addVerbsButton.layout()
        self.seeAllVerbsButton.layout()
        self.yourStatisticsButton.layout()
    }
    
    // ------------------
    // MARK: - Navigation
    // ------------------
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*  If they is not verb to review, and the user click on the button to review this empty list of verb, nothing should happen.
         Normally the buttons that leads the verb revision should be desable on that case (ie. no verb to review)
         But it is a 2nd layer protection in case if they are not
         */
        if segue.identifier == "reviewVerbs" && self.nbrVerbInReviewList == 0 {
            // Nothing sould happen
        }
        else if segue.identifier == "reviewVerbs"{
            prepareReviewVerbsVC(segue)
        }
        else if segue.identifier == "listAllVerbs" {
            prepareListVerbsVC(segue)
        }
    }
    
    private func prepareReviewVerbsVC(_ segue: UIStoryboardSegue){
        let cv = segue.destination as! ReviewVerbsVC
        
        do {
            let verbsRangeToReviewToday = try DAO.shared.verbsToReviewToday(limit: nbrVerbInReviewSession)
            cv.verbsToReview = verbsRangeToReviewToday
        }
        catch{
            cv.verbsToReview = []
        }
    }
    
    private func prepareListVerbsVC(_ segue: UIStoryboardSegue){
        let cv = segue.destination as! ListVerbsVC
        do {
            cv.learningVerbs = try DAO.shared.all()
        }
        catch{
            cv.learningVerbs = []
        }
    }
    
    
    
    // ------------------
    // MARK: - Private: SetUp this access to the database
    // ------------------
    
    
    /// Set the database needed for this screen or show the error if they is one by using a popup
    private func setUpData(){
        if Database.shared.successfulConnection{
            do{
                self.nbrVerbInReviewList = try DAO.shared.nbrVerbInReviewList()
                self.nbrVerbToReviewToday = try DAO.shared.nbrVerbToReviewToday()
                
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
        self.nbrVerbInReviewListLabel.text = "verbe(s) à revoir sur " + String(self.nbrVerbInReviewList) + " dans la liste de révision"
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
