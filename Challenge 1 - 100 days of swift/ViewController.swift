//
//  ViewController.swift
//  Challenge 1 - 100 days of swift
//
//  Created by Enzo Rossetto on 28/06/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        if let items = try? fm.contentsOfDirectory(atPath: path) {
            let sortedItems = items.sorted()
            
            for item in sortedItems {
                if item.hasSuffix(".png") {
                    flags.append(item)
                }
            }
            
            print(flags)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = flags[indexPath.row]
            vc.viewTitle = "Flag \(indexPath.row + 1) of \(flags.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

