//
//  DetailsVC.swift
//  Dictionary(URLSession)
//
//  Created by Hasan Esat Tozlu on 21.09.2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    var selectedWord: Words?
    
    @IBOutlet weak var engLabel: UILabel!
    @IBOutlet weak var turLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedWord = selectedWord {
            engLabel.text = selectedWord.ingilizce
            turLabel.text = selectedWord.turkce
        }
        
    }

}
