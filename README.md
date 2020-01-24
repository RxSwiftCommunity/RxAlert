# RxAlert

## Overview

We have made it easy to implement UIAlertController using RxSwift.


|build|status|
|:-------|:---|
|travis CI|[![](https://travis-ci.org/RxSwiftCommunity/RxAlert.svg?branch=master)](https://travis-ci.org/RxSwiftCommunity/RxAlert)|


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

## Sample code

```
alert(title: "RxAlert",
      message: "We have made it easy to implement UIAlertController using RxSwift.")
      .subscribe()
      .disposed(by: disposeBag)
```

[LICENCE](https://github.com/RxSwiftCommunity/RxAlert/blob/master/LICENSE)

Copyright (c) RxSwiftCommunity
