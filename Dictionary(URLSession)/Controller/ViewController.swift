//
//  ViewController.swift
//  Dictionary(URLSession)
//
//  Created by Hasan Esat Tozlu on 21.09.2022.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dictTableView: UITableView!
    var wordList = [Words]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dictTableView.delegate = self
        dictTableView.dataSource = self
        searchBar.delegate = self
        getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sender = sender as! Int
        let selectedWord = wordList[sender]
        if segue.identifier == "toDetails" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedWord = selectedWord
        }
    }
    
    func getData() {
        let url = URL(string: "http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Data error")
                return
            }
            
            do {
                let dictionaryResponse = try JSONDecoder().decode(DictionaryResponse.self, from: data!)
                if let words = dictionaryResponse.kelimeler {
                    self.wordList = words
                }
                
                DispatchQueue.main.async {
                    self.dictTableView.reloadData()
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func searchText(searchText: String) {
        
        let url = URL(string: "http://kasimadalan.pe.hu/sozluk/kelime_ara.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "ingilizce=\(searchText)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Data error")
                return
            }
            
            do {
                let dictionaryResponse = try JSONDecoder().decode(DictionaryResponse.self, from: data!)
                if let words = dictionaryResponse.kelimeler {
                    self.wordList = words
                }
                
                DispatchQueue.main.async {
                    self.dictTableView.reloadData()
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let word = wordList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "dictionaryCell", for: indexPath) as! DictionaryCell
        cell.turLabel.text = word.turkce
        cell.engLabel.text = word.ingilizce
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: indexPath.row)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText(searchText: searchText)
    }
}


