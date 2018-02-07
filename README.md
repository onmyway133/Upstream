# Upstream

[![CI Status](https://img.shields.io/circleci/project/github/hyperoslo/Upstream.svg)](https://circleci.com/gh/hyperoslo/Upstream)
[![Version](https://img.shields.io/cocoapods/v/Upstream.svg?style=flat)](http://cocoadocs.org/docsets/Upstream)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Upstream.svg?style=flat)](http://cocoadocs.org/docsets/Upstream)
[![Platform](https://img.shields.io/cocoapods/p/Upstream.svg?style=flat)](http://cocoadocs.org/docsets/Upstream)
![Swift](https://img.shields.io/badge/%20in-swift%204.0-orange.svg)

## Description

Arguably one of the first things we learn about iOS development is rendering a list of items using `UITableView, UICollectionView`, and that is also the task we do every day. We mostly do the same task again and again, fetch and parse json, register cells and manually manage data sources.

Using a framework gives you a boost at the start, but it also limits you in many ways. Using `UITableView`, `UICollectionView` is absolutely the right choice as sometimes we need just that. But think about that for a minute, most of the times we just need to do `UITableView, UICollectionView` right with little effort, especially when it comes to data with multiple sections and cell types.

`Upstream` is a very small Data Source class that guides you to implement declarative and type safe data source. It's inspired by [React](https://reactjs.org/) in that the source of truth comes from the model, and the cells are just representation of that.

## Features

- Works on both `UITableView` and `UICollectionView`
- Separation of concern
- Generic
- Type safed
- Expose convenient `configure, select, size` methods

## Usage

#### Declaring model

```swift
<API>
```

## Installation

**Upstream** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Upstream'
```

**Upstream** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "hyperoslo/Upstream"
```

**Upstream** can also be installed manually. Just download and drop `Sources` folders in your project.

## Author

hyperoslo, ios@hyper.no

## Contributing

We would love you to contribute to **Upstream**, check the [CONTRIBUTING](https://github.com/hyperoslo/Upstream/blob/master/CONTRIBUTING.md) file for more info.

## License

**Upstream** is available under the MIT license. See the [LICENSE](https://github.com/hyperoslo/Upstream/blob/master/LICENSE.md) file for more info.
