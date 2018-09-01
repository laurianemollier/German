//
//  ListVerbsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class ListVerbsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var learningVerbs: [UserLearningVerb]!
    var currentLearningVerbs: [UserLearningVerb]!
    
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentLearningVerbs = self.learningVerbs
        alterLayout()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.table.separatorStyle = .none
        
//        self.searchBar.layer.cornerRadius = 3.0
//        self.searchBar.clipsToBounds = true
//        self.searchBar.layer.borderColor = UIColor.blue.cgColor
//        self.searchBar.layer.borderWidth = 1
        
//        self.searchBar.tintColor = UIColor.blue
//        self.searchBar.barTintColor = UIColor.red
        self.searchBar.barStyle = .black
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listVerbsTVCell") as? ListVerbsTVCell else {
            SpeedLog.print("The id 'listVerbsTVCell' can not be found")
            return UITableViewCell()
        }
        cell.setUp(userLearningVerb: self.currentLearningVerbs[indexPath.row])
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
//
        self.searchBar.placeholder = "Search Animal by Name" // TODO
    }
    
    private func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    

}
