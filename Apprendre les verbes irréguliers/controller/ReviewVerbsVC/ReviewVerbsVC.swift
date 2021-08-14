import Foundation
import UIKit
import AVFoundation

class ReviewVerbsVC: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    var index: Int = 0
    var verbsToReview: [LearningVerb]!
    var resultVerbsReviewed: [LearningVerb] = []
    
    var forwardCardVC: ForwarCardVC!
    var backwardCardVC: BackwardCardVC!
    
    
    var isCardForward: Bool!
    
    // ------------------
    // MARK: - Outlets
    // ------------------
    
    @IBOutlet weak var progressionLabel: UILabel!
    
    @IBOutlet weak var audioButton: UIButton!
    
    // --- card ---
    
    @IBOutlet weak var forwarCard: UIView!
    
    @IBOutlet weak var backwardCard: UIView!
    
    @IBOutlet weak var buttonOnCard: UIButton!
    
    // ---
    
    @IBOutlet weak var revealButton: UIButton!
    
    // ---
    
    @IBOutlet weak var explainationLabel: UILabel!
    
    @IBOutlet weak var regressionButton: BasicButton!
    @IBOutlet weak var stagnationButton: BasicButton!
    @IBOutlet weak var progressionButton: BasicButton!
    
    
    // ------------------
    // MARK: - Actions
    // ------------------
    
    @IBAction func back(_ sender: UIButton) {
        back()
    }
    
    @IBAction func audio(_ sender: UIButton) {
        if(Audio.shared.isOn()){
            audioButton.setTitle("🔕", for: .normal)
            Audio.shared.off()
            audioStop()
        }
        else{
            audioButton.setTitle("🔔", for: .normal)
            Audio.shared.on()
        }
    }
    
    @IBAction func revealClickButton(_ sender: UIButton) {
        revealCard(sender)
    }
    
    @IBAction func revealClickOnCard(_ sender: UIButton) {
        revealCard(sender)
    }
    
    @IBAction func regress(_ sender: BasicButton) {
        let verbReviewed: LearningVerb = currentVerb()
        let (newProgression, dateToReview) = verbReviewed.userProgression.regression(reviewedDate: verbReviewed.dateToReview!)!
        updatedVerbReviewed(newProgression: newProgression, dateToReview: dateToReview)
    }
    
    @IBAction func stagnate(_ sender: BasicButton) {
        let verbReviewed: LearningVerb = currentVerb()
        let (newProgression, dateToReview) = verbReviewed.userProgression.stagnation(reviewedDate: verbReviewed.dateToReview!)!
        updatedVerbReviewed(newProgression: newProgression, dateToReview: dateToReview)
        
    }
    
    @IBAction func progress(_ sender: BasicButton) {
        let verbReviewed: LearningVerb = currentVerb()
        let (newProgression, dateToReview) = verbReviewed.userProgression.progression(reviewedDate: verbReviewed.dateToReview!)!
        updatedVerbReviewed(newProgression: newProgression, dateToReview: dateToReview)
    }
    
    
    // ----------------------
    // MARK: - View overrides
    // ----------------------
    
    override func viewWillAppear(_ animated: Bool) {
        
        // display the correct sounds button
        if(Audio.shared.isOn()){
            audioButton.setTitle("🔔", for: .normal)
        }
        else{
            audioButton.setTitle("🔕", for: .normal)
        }
        
        resetCard(verb: self.verbsToReview[self.index].verb)
    }
    
    @objc private func cancelTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // ------------------
    // MARK: - Navigation
    // ------------------
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forwardCardSegue"{
            self.forwardCardVC = segue.destination as? ForwarCardVC
        }
        else if segue.identifier == "backCardSegue"{
            self.backwardCardVC = segue.destination as? BackwardCardVC
        }
    }
    
    // ------------------
    // MARK: - Private
    // ------------------
    
    
    private func currentVerb() -> LearningVerb {
        return self.verbsToReview[self.index]
    }
    
    private func updatedVerbReviewed(newProgression: UserProgression, dateToReview: Date?){
        let verbReviewed: LearningVerb = currentVerb()
        let updatedVerbReviewed = LearningVerb(id: verbReviewed.id,
                                                   verb: verbReviewed.verb,
                                                   dateToReview: dateToReview,
                                                   userProgression: newProgression)
        
        nextVerb(updatedVerbReviewed: updatedVerbReviewed)
    }
    
    
    private func nextVerb(updatedVerbReviewed: LearningVerb?){
        audioStop()
        
        if let v = updatedVerbReviewed {
            self.resultVerbsReviewed.append(v)
        }
        self.index += 1
        
        // End of the revision session
        if self.index >= self.verbsToReview.count{
            endRevisionSession()
        }
        else{
            resetCard(verb: self.verbsToReview[self.index].verb)
        }
    }
    
    
    private func flipCard(visible: UIView, notVisibleYet: UIView){
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: visible, duration: 1.0, options: transitionOptions, animations: {
            visible.isHidden = true
        })
        
        UIView.transition(with: notVisibleYet, duration: 1.0, options: transitionOptions, animations: {
            notVisibleYet.isHidden = false
        })
        
        self.isCardForward = !self.isCardForward
    }
    
    
    private func revealCard(_ sender: UIButton){
        if self.isCardForward{
            flipCard(visible: self.forwarCard, notVisibleYet: self.backwardCard)
            self.isCardForward = false
            if Audio.shared.isOn(){
                audioPlay(verb: self.currentVerb().verb)
            }
        }
        else{
            flipCard(visible: self.backwardCard, notVisibleYet: self.forwarCard)
            self.isCardForward = true
            audioStop()
        }
        
        
        self.revealButton.isHidden = true
        
        self.explainationLabel.isHidden = false
        self.regressionButton.isHidden = false
        self.stagnationButton.isHidden = false
        self.progressionButton.isHidden = false
        
        let progression = self.currentVerb().userProgression
        self.regressionButton.setTitle(progression.regressionName(), for: .normal)
        self.stagnationButton.setTitle(progression.stagnationName(), for: .normal)
        self.progressionButton.setTitle(progression.progressionName(), for: .normal)
        
    }
    
    
    private func resetCard(verb: Verb){
        self.isCardForward = true
        self.forwarCard.isHidden = false
        self.backwardCard.isHidden = true
        
        self.revealButton.isHidden = false
        
        self.explainationLabel.isHidden = true
        self.regressionButton.isHidden = true
        self.stagnationButton.isHidden = true
        self.progressionButton.isHidden = true
        
        self.forwardCardVC.reset(verb: verb)
        
        // Set the data in for the back of the car
        self.backwardCardVC.reset(verb: verb)
        
        
        // Progression label
        self.progressionLabel.text = textProgressionLabel()
    }
    
    
    private func endRevisionSession(){
        let dbResultVerbsReviewed = resultVerbsReviewed.map({ $0.toDbUserLearningVerb()})
        do{
            let results: [Int] = try DAO.shared.update(learningVerbs: dbResultVerbsReviewed)
            if results.forAll(where: {$0 > 0})  {
                back()
                SpeedLog.print("Sucessly modify all learning verb")
            }
            else{
                // TODO
                SpeedLog.print("One verb was not found")
            }
        }
        catch{
            // TODO
            SpeedLog.print(error)
        }
    }
    
    
    private func textProgressionLabel() -> String {
        return String(self.index + 1) + "/" + String(self.verbsToReview.count)
    }
    
    private func back(){
        dismiss(animated: true, completion: nil)
    }
    
    
    // --- audio ---
    
    private func audioPlay(verb: Verb){
        do {
            let formatAudio = "mp3"
            let nameAudioFile = verb.infinitive()
            let audioURL = URL(fileURLWithPath: Bundle.main.path(forResource: nameAudioFile, ofType: formatAudio)!)
            audioPlayer = try! AVAudioPlayer(contentsOf: audioURL, fileTypeHint: nil)
            audioPlayer!.play()
            audioPlayer!.numberOfLoops = 0
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            // report for an error
            SpeedLog.print(error) // TODO
        }
    }
    
    
    private func audioStop(){
        if audioPlayer != nil && audioPlayer!.isPlaying{
            audioPlayer!.stop()
        }
    }
}
