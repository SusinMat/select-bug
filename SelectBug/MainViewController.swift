//
//  MainViewController.swift
//  SelectBug
//
//  Created by Matheus Martins Susin on 2020-01-29.
//  Copyright © 2020 Matheus Martins Susin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var editingStyle: UITableViewCell.EditingStyle!

    // MARK: - testSwipe POI
    // set selectionDelay to:
    // 1.0 or higher, for all tests to succeed
    // 0.9 or lower, for a test to fail
    var selectionDelay: TimeInterval = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        // MARK: - testSwitches POI
//        tableView.allowsMultipleSelectionDuringEditing = true

        editingStyle = UITableViewCell.EditingStyle.init(rawValue: 3)
    }

    @IBAction func buttonTouchUp(_ sender: Any) {
        for cell in tableView.visibleCells as! [NumberedCell] {
            if cell.isSelected {
                NSLog("Cell currently at \(cell.positionLabel.text!) was selected")
            }
        }
        tableView.setEditing(!tableView.isEditing, animated: true)

        if tableView.isEditing == false {
            return
        }

        let deadlineTime = DispatchTime.now() + .milliseconds(1000)

        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
            guard self != nil else {
                return
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Numbered Cell", for: indexPath) as! NumberedCell
        cell.positionLabel.text = "Pos. \(indexPath)"
        cell.originalPositionLabel.text = "Orig. pos. \(indexPath)"
        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return editingStyle
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAction = UIContextualAction(style: .normal, title: "Swap") { (action, view, handler) in
            tableView.setEditing(false, animated: false)
            tableView.setEditing(true, animated: true)
            let deadlineTime = DispatchTime.now() + .milliseconds(Int(1000 * self.selectionDelay))
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
            handler(true) // Will do the animation
        }
        swipeAction.backgroundColor = UIColor.systemTeal

        return UISwipeActionsConfiguration(actions: [swipeAction])
    }

    func update(cellAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? NumberedCell {
            cell.positionLabel.text = "Pos. \(indexPath)"
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRows = tableView.indexPathsForSelectedRows
        if selectedRows == nil || selectedRows!.count != 2 {
            return
        }
        let first = selectedRows![0]
        let second = selectedRows![1]
        tableView.beginUpdates()
        tableView.moveRow(at: first, to: second)
        tableView.moveRow(at: second, to: first)
        tableView.endUpdates()
        self.update(cellAt: first)
        self.update(cellAt: second)
        tableView.setEditing(false, animated: true)
    }
}
