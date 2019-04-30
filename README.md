# RxAlert

## Overview

|build|status|
|:-------|:---|
|travis CI|![](https://travis-ci.org/keisukeYamagishi/RxAlert.svg?branch=master)|

We have made it easy to implement UIAlertController using RxSwift.

## Carthage

```
brew install carthage
```

Add following to Cartfile:

```
github "RxSwiftCommunity/RxAlert"
```

## Cocoapods

[CocoaPods](https://cocoapods.org/pods/RxAlertExtension) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
To integrate TabPageScrollViewController into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
vi ./Podfile
```

Add following to Podfile

```
pod 'RxAlertExtension'
```

## Use it

***Via SSH***: For those who plan on regularly making direct commits, cloning over SSH may provide a better experience (which requires uploading SSH keys to GitHub):

```
$ git clone git remote add origin git@github.com:keisukeYamagishi/TabPageScrollViewController.git
```
***Via https***: For those checking out sources as read-only, HTTPS works best:

```
$ git clone https://github.com/keisukeYamagishi/TabPageScrollViewController.git
```

## Sample code

```
alert(title: "RxAlert",
              message: "RxAlert Message",
              actions: [AlertAction(title: "OK", type: 0, style: .default)],
              vc: self).observeOn(MainScheduler.instance)
            .subscribe(onNext: { index in
                print ("index: \(index)")
                
            }).disposed(by: disposeBag)
```

[LICENCE](https://github.com/keisukeYamagishi/RxAlert/blob/master/LICENSE)

Copyright (c) RxSwiftCommunity
