//
//  ListVerbsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class ListVerbsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let verbDetailsSegueId = "verbDetailsSegue"
    
    
    var showIfVerbIsInReviewList: Bool = true
    
    
    var titleList: String!
    
    var learningVerbs: [LearningVerb]!
    var currentLearningVerbs: [LearningVerb]!
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var titleListLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentLearningVerbs = self.learningVerbs
        alterLayout()
        
        let nibName = UINib(nibName: "ListVerbsCell", bundle: nil)
        table.register(nibName, forCellReuseIdentifier: "listVerbsCell")
        self.titleListLabel.text = titleList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.table.separatorStyle = .none
        
        self.searchBar.layer.borderColor = UIColor(rgb: 0xdd0000).cgColor // TODO save this red
        self.searchBar.layer.borderWidth = 0
        
        
        self.searchBar.tintColor = UIColor(rgb: 0xdd0000)
        self.searchBar.barTintColor = UIColor(rgb: 0xdd0000)
        
        
        if let selectedIndexPath = table.indexPathForSelectedRow {
            table.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        back()
    }
    
    
    
    // MARK: - TableView
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentLearningVerbs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listVerbsCell") as? ListVerbsCell else {
            SpeedLog.print("The id 'listVerbsCell' can not be found")
            return UITableViewCell()
        }
        cell.setUp(userLearningVerb: self.currentLearningVerbs[indexPath.row], showIfVerbIsInReviewList: showIfVerbIsInReviewList)
        
        return cell
    }
    
    // click on one cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as! ListVerbsCell
        performSegue(withIdentifier: verbDetailsSegueId, sender: cell)
    }
    
    
    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        guard !searchText.isEmpty else {
            self.currentLearningVerbs = self.learningVerbs
            self.table.reloadData()
            return
        }
        
        self.currentLearningVerbs = self.learningVerbs.filter({ learningVerb -> Bool in
            guard let text = searchBar.text else {return false}
            return true // learningVerb.verb.infinitive().lowercased().contains(text.lowercased())
        })
        self.table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        // TODO
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == verbDetailsSegueId {
            let vc = segue.destination as! VerbDetailsVC
            let cell = sender as! ListVerbsCell
            vc.userLearningVerb = cell.userLearningVerb
        }
        else {
            // TODO
            SpeedLog.print("Should no happen")
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    
    func alterLayout() {
        self.searchBar.placeholder = "Chercher un verbe" // TODO
    }
    
    private func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
}
