//
//  GenrePickerViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/17/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class GenrePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {

    @IBOutlet weak var genrePicker: UIPickerView!
    var superHero: SuperheroViewController?
    
    let pickerData:[(name: String, id: Int)] = [
                                        ("Action", 28),
                                        ("Adevnture", 12),
                                        ("Animated", 16),
                                        ("Comedy", 35),
                                        ("Crime", 80),
                                        ("Documentary", 99),
                                        ("Drama", 18),
                                        ("Family", 10751),
                                        ("Fantasy", 14),
                                        ("History", 36),
                                        ("Horror", 27),
                                        ("Music", 10402),
                                        ("Mystery", 9648),
                                        ("Romance", 10749),
                                        ("Science Fiction", 878),
                                        ("TV Movie", 10770),
                                        ("Thriller", 53),
                                        ("War", 10752),
                                        ("Western", 37)
                                    ]
    var genreID = 0
    var genreName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genrePicker.delegate = self
        genrePicker.dataSource = self
        navigationController?.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genreName = pickerData[row].name
        genreID = pickerData[row].id
    }
    
    @IBAction func setGenre(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        (viewController as? SuperheroViewController)?.genreName = genreName
        (viewController as? SuperheroViewController)?.genreID = genreID
        (viewController as? SuperheroViewController)?.viewDidLoad()
        
    }
    
}
