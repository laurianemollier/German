//
//  ListVerbsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class ListVerbsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    var showIfVerbIsInReviewList: Bool = true
    
    
    var titleList: String!
    
    var learningVerbs: [UserLearningVerb]!
    var currentLearningVerbs: [UserLearningVerb]!
    
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
//        self.currentLearningVerbs = self.learningVerbs.filter({ learningVerb -> Bool in
//            switch searchBar.selectedScopeButtonIndex{
//
//            }
//        })
        
        
        guard !searchText.isEmpty else {
            self.currentLearningVerbs = self.learningVerbs
            self.table.reloadData()
            return
        }
        
        self.currentLearningVerbs = self.learningVerbs.filter({ learningVerb -> Bool in
            guard let text = searchBar.text else {return false}
            return learningVerb.verb.infinitive().lowercased().contains(text.lowercased())
        })
        self.table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        // TODO
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func alterLayout() {
        self.searchBar.placeholder = "Chercher un verbe" // TODO
    }
    
    private func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    

}
