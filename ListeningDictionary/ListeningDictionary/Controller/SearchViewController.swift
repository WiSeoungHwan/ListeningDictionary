//
//  SearchViewController.swift
//  ListeningDictionary
//
//  Created by Wi on 03/08/2019.
//  Copyright © 2019 Wi. All rights reserved.
//
import UIKit

class SearchViewController: UITableViewController {
    
    // MARK: - Private Field
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchWord = ""
    private var currentCaption = Caption(videoId: "", caption: "", time: "")
    private var searchResults = [Caption]()
    
    // MARK: xml parser field
    
    var rowStart = false
    var cellStart = false
    var cellCount = 0
    var rowCount = 0
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        xmlParse()
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusecell = tableView.dequeueReusableCell(withIdentifier: "cell"){
            cell = reusecell
        }else{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = searchResults[indexPath.row].caption
        cell.detailTextLabel?.text = "\(searchResults[indexPath.row].videoId) - \(searchResults[indexPath.row].time)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.caption = searchResults[indexPath.row]
        detailVC.searchWord = self.searchWord
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Private func
    
    private func configure(){
        self.title = "Search"
        self.tabBarItem.title = "Search"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.searchController.obscuresBackgroundDuringPresentation = false // 검색하는 동안 기본내용이 가려져 있을지
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
    }
    
    private func xmlParse(){
        searchResults = []
        guard
            let url = Bundle.main.url(forResource: "caption", withExtension: "xml")
            else { print("xmlFile is nil"); return}
        guard
            let xmlParser = XMLParser(contentsOf: url)
            else {print("xmlParser error"); return}
        xmlParser.delegate = self
        xmlParser.parse()
    }

}

extension SearchViewController: XMLParserDelegate{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Row"{
            rowStart = true
        }
        if elementName == "Cell"{
            cellStart = true
        }
        if rowStart && elementName == "Cell"{
            cellCount += 1
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard cellStart else {return}
        switch cellCount {
        case 1:
            currentCaption.videoId = string
        case 2:
            currentCaption.caption = string
        case 3:
            currentCaption.time = string
        default:
            break
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Row"{
//            print(currentCaption)
            if currentCaption.caption.contains(searchWord){
                searchResults.append(currentCaption)
                rowCount += 1
            }
            if rowCount == 5 {
                parser.abortParsing()
                
                let pageVC = DetailPageViewController()
                pageVC.searchResults = searchResults
                present(pageVC, animated: true, completion: nil)
            }
            rowStart = false
        }
        if elementName == "Cell"{
            cellStart = false
        }
        if cellCount >= 3{
            cellCount = 0
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        print(searchResults)
        
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("row count is over")
    }
}

// MARK: - UISearchResultsUpdating Delegate

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // searchBar 에서 글자를 눌렀을 때
        
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // 스코프를 눌렀을때
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // cancel 버튼 눌렀을때
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchWord = searchBar.text!
        xmlParse()
    }
}
