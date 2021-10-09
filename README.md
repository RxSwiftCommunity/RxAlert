# RxAlert

## Overview

We have made it easy to implement UIAlertController using RxSwift.


|build|status|
|:-------|:---|
|Github Actions|[![build](https://github.com/RxSwiftCommunity/RxAlert/actions/workflows/rxalert.yml/badge.svg?branch=master)](https://github.com/RxSwiftCommunity/RxAlert/actions/workflows/rxalert.yml)|


## Use it

***Via SSH***: For those who plan on regularly making direct commits, cloning over SSH may provide a better experience (which requires uploading SSH keys to GitHub):

```
$ git clone git@github.com:RxSwiftCommunity/RxAlert.git
```
***Via https***: For those checking out sources as read-only, HTTPS works best:

```
$ git clone https://github.com/RxSwiftCommunity/RxAlert.git
```

## Carthage

Add following to Cartfile:

```
github "RxSwiftCommunity/RxAlert"
```

## Cocoapods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate RxAlert into your Xcode project using CocoaPods, add following line to the Podfile

```
pod 'RxUIAlert'
```

## Usage

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:


```
pod install 
```

## Sample code

```
// normal alert
rx.alert(title: "RxAlert",
         message: "We have made it easy to implement UIAlertController using RxSwift.")
   .subscribe()
   .disposed(by: disposeBag)

// textField
rx.alert(title: "RxAlert",
         message: "We have made it easy to implement UIAlertController using RxSwift.",
         actions: [AlertAction(title: "OK", type: 0, style: .default),
                   AlertAction(textField: UITextField(), placeholder: "user name"),
                   AlertAction(textField: UITextField(), placeholder: "password")])
    .subscribe(onNext: { (output) in
        output.textFields?.forEach {
            print ($0.text as? String?)
        }})
    .disposed(by: disposeBag)

// actionsheet
rx.alert(title: "RxAlert",
         message: "RxAlert Message",
         preferredStyle: .actionSheet)
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { index in
        print("index: \(index)")
    }).disposed(by: disposeBag)

```

[LICENCE](https://github.com/RxSwiftCommunity/RxAlert/blob/master/LICENSE)

Copyright (c) RxSwiftCommunity
