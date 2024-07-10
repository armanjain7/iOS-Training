//
//  ViewController.swift
//  MyContacts
//
//  Created by Raramuri on 08/07/24.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var names = [String]()
    var sectionTitle = [String]()
    var nameDict = [String:[String]]()
    var searchContact = [String]()
    var finalContact = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "Name", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let name = try JSONDecoder().decode([String].self, from: data)
            for items in name {
                names.append(items)
            }
        }
        catch{
            print("Parsing Error")
        }
        
        sectionTitle = Array(Set(names.compactMap({String($0.prefix(1))})))
        sectionTitle.sort()
        finalContact = names
        for sTitle in sectionTitle
        {
            nameDict[sTitle] = [String]()
        }
        for name in names{
            nameDict[String(name.prefix(1))]?.append(name)
        }
        
    }
    }
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "details")
        vc.navigationItem.title = nameDict[sectionTitle[indexPath.section]]?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameDict[sectionTitle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = nameDict[sectionTitle[indexPath.section]]?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitle
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        searchContact = names.filter({$0.lowercased().contains(searchText.lowercased())})
        finalContact = searchContact
        sectionTitle = Array(Set(finalContact.compactMap({value in
            String(value.prefix(1))
        })))
        
        sectionTitle.sort()
        for secTitle in sectionTitle {
            nameDict[secTitle] = [String]()
        }
        
        for name in finalContact {
            nameDict[String(name.prefix(1))]?.append(name)
        }
        tableView.reloadData()
        }
}

