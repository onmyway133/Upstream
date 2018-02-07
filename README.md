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

`Upstream` is a very in that guides you to implement declarative and type safe data source. It's inspired by [React](https://reactjs.org/) in that the source of truth comes from the model, and the cells are just representation of that.

`Upstream` is generic and should not limit you in any ways. If you don't like it, just implement your own `DataSource` class.

### Features

- Works on both `UITableView` and `UICollectionView`
- Separation of concern
- Generic
- Type safed
- Expose convenient `configure, select, size` methods
- Just manage Data Source and Delegate, keep your `UITableView` and `UICollectionView` intact

### Plan

`Upstream` is based on minion `Service` classes that you can use for many boring tasks

- [x] RegistryService: auto checks and registers cells if needed
- [ ] DeepService: performs diff on your model changes so `UITablView, UICollectionView` gets reredendered nicely. 
- [ ] PaginationService: handles load more and pagination
- [ ] StateService: handles empty, loading, content, error states

Also, there are some layout that we need often

- [ ] CarouselCell: used for carousel inside a list

## Usage

### Section and Item

Usually we get json data, parse it to model and use that model to drive the cell. In fact, what we really need is to map `model -> cell`, or "I want to show this cell for this model"

The core concept of `Upstream` is `UI = f(model)`. The model is a collection of sections

```swift
public struct Section<T> {
  let header: Header<T>?
  let items: [Item<T>]
  let footer: Footer<T>?
}
```

Each section can container either header, footer and a collection of items.

```
public struct Item<T> {
  let model: T
  let cellType: UIView.Type
}
```

Header, Footer, Cell are just `UIView` under the hood, and are driven by `Model`.

### Step 1: Model

Since `Upstream` is a generic, your model can be struct, enum or protocol. Here is an example on how to structure your Profile screen. Each enum case represents the kind of model this screeen can show. And by just looking at the model, you know exactly what your `UITableView, UICollectionView` is going to show. You typically should do this inside `UIViewController`.

```swift
class ProfileViewController: UIViewController {
  enum Model {
    case header(String)
    case avatar(URL)
    case name(String)
    case location(String)
    case skill(String)
  }
}
```

### Step 2: Manager

`Manager` is the class that handles Data Source and Delegate methods. It is `open` so that you can override and add new stuff if you like

```swift
let manager = Manager<Model>(tableView: tableView)
manager.delegate = self
tableView.dataSource = manager
tableView.delegate = manager
```

### Step 3: Section

Each section will map to a section in `UITableView, UICollectionView`

```swift
let sections: [Section<Model>] = [
  Section(
    header: Header(model: .header("Information"), viewType: HeaderView.self),
    items: [
      Item(model: .avatar(avatarUrl), cellType: AvatarCell.self),
      Item(model: .name("Thor"), cellType: NameCell.self),
      Item(model: .location("Asgard"), cellType: NameCell.self)
    ]
  ),
  Section(
    header: Header(model: .header("Skills"), viewType: HeaderView.self),
    items: [
      Item(model: .skill("iOS"), cellType: SkillCell.self),
      Item(model: .skill("Android"), cellType: SkillCell.self)
    ]
  )
]

manager.reload(sections: sections)
```

Just call `manager.reload`. Your header, footer, cell types are automatically registered and reloaded.

### Step 4: Delegate

The 3 methods we need the most are:

- `configure`: how to configure the view using the model
- `size`: what is the size of the view
- `select`: what do you when a cell is selected

These are universal for header, footer, cells. Due to generic protocol not be able to declare, we need to use `Any`.

If you don't like switch case, you can make your `Model` as protocol instead of enum.

```swift
extension ProfileViewController: ManagerDelegate {
  func configure(model: Any, view: UIView) {
    guard let model = model as? Model else {
      return
    }

    switch (model, view) {
    case (.avatar(let string), let cell as Avatarcell):
      cell.configure(string: string)
    case (.name(let name), let cell as NameCell):
      cell.configure(string: name)
    case (.header(let string), let view as HeaderView):
      view.configure(string: string)
    default:
      break
    }
  }

  func select(model: Any) {
    guard let model = model as? Model else {
      return
    }

    switch model {
    case .skill(let skill):
      let skillController = SkillController(skill: skill)
      navigationController?.pushViewController(skillController, animated: true)
    default:
      break
    }
  }

  func size(model: Any, containerSize: CGSize) -> CGSize {
    guard let model = model as? Model else {
      return .zero
    }

    switch model {
    case .name:
      return CGSize(width: containerSize.width, height: 40)
    case .avatar:
      return CGSize(width: containerSize.width, height: 200)
    case .header:
      return CGSize(width: containerSize.width, height: 30)
     default:
       return .zero
    }
  }
}

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
