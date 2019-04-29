/*
 MIT License
 
 Copyright (c) RxSwiftCommunity
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

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

