import UIKit

public protocol AdapterDelegate: class {

  /// Apply model to view
  func configure(model: Any, view: UIView, indexPath: IndexPath)

  /// Handle view selection
  func select(model: Any)

  /// Size the view
  func size(model: Any, containerSize: CGSize) -> CGSize
}

/// Act as DataSource and Delegate for UICollectionView, UITableView
open class Adapter: NSObject,
  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
UITableViewDataSource, UITableViewDelegate {

  public var sections: [Section] = []
  public weak var collectionView: UICollectionView?
  public weak var tableView: UITableView?
  public weak var delegate: AdapterDelegate?

  let registryService = RegistryService()

  // MARK: - Initialiser
  public required init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    super.init()
  }

  public required init(tableView: UITableView) {
    self.tableView = tableView
    super.init()
  }

  // MARK: - UICollectionViewDataSource

  open func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }

  open func collectionView(_ collectionView: UICollectionView,
                           numberOfItemsInSection section: Int) -> Int {
    return sections[section].items.count
  }

  open func collectionView(_ collectionView: UICollectionView,
                           cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = sections[indexPath.section].items[indexPath.row]
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: item.cellType.typeName,
      for: indexPath)

    delegate?.configure(model: item.model, view: cell, indexPath: indexPath)

    return cell
  }

  open func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath) -> UICollectionReusableView {

    if let header = sections[indexPath.section].header,
      kind == UICollectionElementKindSectionHeader {

      let view = collectionView.dequeueReusableSupplementaryView(
        ofKind: UICollectionElementKindSectionHeader,
        withReuseIdentifier: header.viewType.typeName,
        for: indexPath
      )

      delegate?.configure(model: header.model, view: view, indexPath: indexPath)
      return view
    } else if let footer = sections[indexPath.section].footer,
      kind == UICollectionElementKindSectionFooter {

      let view = collectionView.dequeueReusableSupplementaryView(
        ofKind: UICollectionElementKindSectionFooter,
        withReuseIdentifier: footer.viewType.typeName,
        for: indexPath
      )

      delegate?.configure(model: footer.model, view: view, indexPath: indexPath)
      return view
    } else {
      let view = DummyReusableView()
      view.isHidden = true
      return view
    }
  }

  // MARK: - UICollectionViewDelegate

  open func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath) {

    let item = sections[indexPath.section].items[indexPath.row]
    delegate?.select(model: item.model)
    collectionView.deselectItem(at: indexPath, animated: true)
  }

  open func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {

    let item = sections[indexPath.section].items[indexPath.row]
    if let size = delegate?.size(model: item.model, containerSize: collectionView.frame.size) {
      return size
    }

    if let size = (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize {
      return size
    }

    return collectionView.frame.size
  }

  open func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection section: Int) -> CGSize {

    guard let header = sections[section].header else {
      return .zero
    }

    guard let size = delegate?.size(model: header.model, containerSize: collectionView.frame.size) else {
      return .zero
    }

    return size
  }

  open func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForFooterInSection section: Int) -> CGSize {

    guard let footer = sections[section].footer else {
      return .zero
    }

    guard let size = delegate?.size(model: footer.model, containerSize: collectionView.frame.size) else {
      return .zero
    }

    return size
  }

  // MARK: - Reload

  open func reload(sections: [Section]) {
    // Registry
    registryService.registerIfNeeded(
      collectionView: collectionView,
      tableView: tableView,
      sections: sections
    )

    self.sections = sections
    collectionView?.reloadData()
    tableView?.reloadData()
  }

  // MARK: - UITableViewDataSource

  open func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].items.count
  }

  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = sections[indexPath.section].items[indexPath.row]
    let cell = tableView.dequeueReusableCell(
      withIdentifier: item.cellType.typeName,
      for: indexPath
    )

    delegate?.configure(model: item.model, view: cell, indexPath: indexPath)

    return cell
  }

  // MARK: - UITableViewDelegate

  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = sections[indexPath.section].items[indexPath.row]
    delegate?.select(model: item.model)
    tableView.deselectRow(at: indexPath, animated: true)
  }

  open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let item = sections[indexPath.section].items[indexPath.row]
    if let size = delegate?.size(model: item.model, containerSize: tableView.frame.size) {
      return size.height
    }

    return 0
  }

  open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let header = sections[section].header else {
      return 0
    }

    guard let size = delegate?.size(model: header.model, containerSize: tableView.frame.size) else {
      return 0
    }

    return size.height
  }

  open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    guard let footer = sections[section].footer else {
      return 0
    }

    guard let size = delegate?.size(model: footer.model, containerSize: tableView.frame.size) else {
      return 0
    }

    return size.height
  }

  open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let header = sections[section].header else {
      return nil
    }

    guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.viewType.typeName) else {
      return nil
    }

    delegate?.configure(model: header.model, view: view, indexPath: IndexPath(row: 0, section: section))
    return view
  }

  open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let footer = sections[section].footer else {
      return nil
    }

    guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.viewType.typeName) else {
      return nil
    }

    delegate?.configure(model: footer.model, view: view, indexPath: IndexPath(row: 0, section: section))
    return view
  }
}
