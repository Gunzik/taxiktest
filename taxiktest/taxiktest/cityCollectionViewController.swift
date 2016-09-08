//
//  cityCollectionViewController.swift
//  taxiktest
//
//  Created by Nikita Kuznetsov on 07.09.16.
//  Copyright © 2016 Nikita Kuznetsov. All rights reserved.
//


import UIKit
import SwiftyJSON


private let reuseIdentifier = "CellCity"


class cityCollectionViewController: UICollectionViewController {
    
     var json: JSON = JSON.null
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadData()
        
    }
    
    func loadData() {
        
        let url = URL(string: "http://beta.taxistock.ru/taxik/api/client/query_cities")
        MOHUD.showSubtitle(title: "Загрузка", subtitle: "Пожалуйста подождите")
        DispatchQueue.global(qos: .background).async {
            
            let data = try? Data(contentsOf: url!)
            
            if (data != nil) {
                
                self.json = JSON(data:data!)
                
                DispatchQueue.main.async {

                    self.collectionView!.reloadData()
                    MOHUD.dismiss()
                }
            }
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.json != nil) {
            return self.json["cities"].count
        }
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! cityCollectionViewCell
        
        let cities = self.json["cities"]
        
        
        let cityname = cities.array
    

        cell.labelNameCity?.text = cityname?[indexPath.row]["city_name"].stringValue

        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "segueCity") {
            
        if let viewMapVC = segue.destination as? viewMapViewController {
            
            let cities = self.json["cities"]
            
            let citiesData = cities.array
            
            let cell = sender as! cityCollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            
            viewMapVC.city_name = (citiesData?[(indexPath?.row)!]["city_name"].stringValue)!
            viewMapVC.city_latitude = (citiesData?[(indexPath?.row)!]["city_latitude"].doubleValue)!
            viewMapVC.city_longitude = (citiesData?[(indexPath?.row)!]["city_longitude"].doubleValue)!
        
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationItem.title = "Список городов"
        
    }}
