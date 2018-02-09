import UIKit

class RegistryService {
  private var registeredTypes = Set<String>()

  func registerIfNeeded<T>(collectionView: UICollectionView?, tableView: UITableView?, sections: [Section<T>]) {
    sections.forEach { section in
      if let header = section.header, !registeredTypes.contains(header.viewType.typeName) {

        if header.viewType == UICollectionReusableView.self {
          collectionView?.register(
            header.viewType,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: header.viewType.typeName
          )
        }

        if header.viewType == UITableViewHeaderFooterView.self {
          tableView?.register(
            header.viewType,
            forHeaderFooterViewReuseIdentifier: header.viewType.typeName
          )
        }

        registeredTypes.insert(header.viewType.typeName)
      }

      if let footer = section.footer, !registeredTypes.contains(footer.viewType.typeName) {
        if footer.viewType == UICollectionReusableView.self {
          collectionView?.register(
            footer.viewType,
            forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: footer.viewType.typeName
          )
        }

        if footer.viewType == UITableViewHeaderFooterView.self {
          tableView?.register(
            footer.viewType,
            forHeaderFooterViewReuseIdentifier: footer.viewType.typeName
          )
        }

        registeredTypes.insert(footer.viewType.typeName)
      }

      section.items.forEach { item in
        if !registeredTypes.contains(item.cellType.typeName) {

          if item.cellType == UICollectionViewCell.self {
            collectionView?.register(
              item.cellType,
              forCellWithReuseIdentifier: item.cellType.typeName
            )
          }

          if item.cellType == UITableViewCell.self {
            tableView?.register(
              item.cellType,
              forCellReuseIdentifier: item.cellType.typeName
            )
          }

          registeredTypes.insert(item.cellType.typeName)
        }
      }
    }
  }
}
