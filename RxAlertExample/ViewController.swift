//
//  ViewController.swift
//  RxAlertExample
//
//  Created by Shichimitoucarashi on 4/28/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit
import RxAlert
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    let items: BehaviorRelay<[String]> = BehaviorRelay(value: ["Alert single","Alert double","Action sheet single","Action sheet triple"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items.bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) { i, item ,cell in
            cell.textLabel!.text = item
        }.disposed(by: disposeBag)
        
        tableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { [weak self] (index) in
                
                switch index.row {
                case 0:
                    self?.alert(title: "RxAlert",
                               message: "RxAlert Message",
                               actions: [AlertAction(title: "OK", type: 0, style: .default)],
                               vc: self!).observeOn(MainScheduler.instance)
                        .subscribe(onNext: { index in
                            print ("index: \(index)")
                            
                        }).disposed(by: self!.disposeBag)
                    break
                case 1:
                    self?.alert(title: "RxAlert",
                               message: "RxAlert Message",
                               actions: [AlertAction(title: "OK", type: 0, style: .default),
                                         AlertAction(title: "Cancel", type: 1, style: .cancel)],
                               vc: self!).observeOn(MainScheduler.instance)
                        .subscribe(onNext: { index in
                            print ("index: \(index)")
                            
                        }).disposed(by: self!.disposeBag)
                    break
                case 2:
                    self!.alert(title: "RxAlert",
                               message: "RxAlert Message",
                               actions: [AlertAction(title: "OK", type: 0, style: .default)],
                               preferredStyle: .actionSheet,
                               vc: self!).observeOn(MainScheduler.instance)
                        .subscribe(onNext: { index in
                            print ("index: \(index)")
                            
                        }).disposed(by: self!.disposeBag)
                    break
                case 3:
                    self!.alert(title: "RxAlert",
                               message: "RxAlert Message",
                               actions: [AlertAction(title: "OK", type: 0, style: .default),
                                         AlertAction(title: "First", type: 1, style: .default),
                                         AlertAction(title: "Cancel", type: 2, style: .cancel)],
                               preferredStyle: .actionSheet,
                               vc: self!).observeOn(MainScheduler.instance)
                        .subscribe(onNext: { index in
                            print ("index: \(index)")
                            
                        }).disposed(by: self!.disposeBag)
                    break
                default:
                    break
                }
            
        }).disposed(by: disposeBag)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alert(title: "RxAlert",
              message: "RxAlert Message",
              actions: [AlertAction(title: "OK", type: 0, style: .default)],
              vc: self).observeOn(MainScheduler.instance)
            .subscribe(onNext: { index in
                print ("index: \(index)")
                
            }).disposed(by: disposeBag)
    }
}

