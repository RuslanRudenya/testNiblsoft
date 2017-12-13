//
//  InfoTableViewController.swift
//  testNiblsoft
//
//  Created by Руслан on 13.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import UIKit
import CoreData

class InfoTableViewController: UITableViewController {
    
    var weatherArray = [WeatherData]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let reqquestFetch: NSFetchRequest<WeatherData> = WeatherData.fetchRequest()
        
        do {
            weatherArray = try context.fetch(reqquestFetch)
        } catch {
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        saveData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! InfoTableViewCell
        cell.cityLbl.text = weatherArray[indexPath.row].city ?? ""
        cell.dateLbl.text = weatherArray[indexPath.row].date ?? ""
        cell.latitudeLbl.text = String(weatherArray[indexPath.row].latitude)
        cell.longitudeLbl.text = String(weatherArray[indexPath.row].longitude)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let historyDataVC = storyBoard.instantiateViewController(withIdentifier: "HistoryDataViewController") as! HistoryDataViewController
        
        historyDataVC.cityStr = weatherArray[indexPath.row].city ?? ""
        historyDataVC.latitudeStr = String(weatherArray[indexPath.row].latitude)
        historyDataVC.longitudeStr = String(weatherArray[indexPath.row].longitude)
        historyDataVC.dateStr = weatherArray[indexPath.row].date ?? ""
        historyDataVC.temprStr = String(weatherArray[indexPath.row].tempret)
       
        self.navigationController?.pushViewController(historyDataVC, animated: true)
    }
    
    
    func saveData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WeatherData", in: context)
        let objectWeather = NSManagedObject(entity: entity!, insertInto: context) as! WeatherData
        
        NetworkService.shared.getData { (response) in
            objectWeather.city = response.location.region
            objectWeather.date = response.location.localtime
            objectWeather.latitude = Double(response.location.lat!)
            objectWeather.longitude = Double(response.location.lon!)
            objectWeather.tempret = response.current.temp_c
            
            DispatchQueue.global(qos: .background).async {
                do {
                    try context.save()
                    self.weatherArray.append(objectWeather)
                } catch {
                    print(error.localizedDescription)
                }
            }
            self.tableView.reloadData()
        }
    }
    

}
