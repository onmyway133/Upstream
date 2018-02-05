import UIKit

class RegistryService {
  private var registeredTypes = Set<String>()

  func registerIfNeeded<T>(collectionView: UICollectionView?, tableView: UITableView?, sections: [Section<T>]) {
    sections.forEach { section in
      if let header = section.header, !registeredTypes.contains(header.viewType.typeName) {
        collectionView?.register(
          header.viewType,
          forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
          withReuseIdentifier: header.viewType.typeName
        )

        tableView?.register(
          header.viewType,
          forHeaderFooterViewReuseIdentifier: header.viewType.typeName
        )

        registeredTypes.insert(header.viewType.typeName)
      }

      if let footer = section.footer, !registeredTypes.contains(footer.viewType.typeName) {
        collectionView?.register(
          footer.viewType,
          forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
          withReuseIdentifier: footer.viewType.typeName
        )

        tableView?.register(
          footer.viewType,
          forHeaderFooterViewReuseIdentifier: footer.viewType.typeName
        )

        registeredTypes.insert(footer.viewType.typeName)
      }

      section.items.forEach { item in
        if !registeredTypes.contains(item.cellType.typeName) {
          collectionView?.register(
            item.cellType,
            forCellWithReuseIdentifier: item.cellType.typeName
          )

          tableView?.register(
            item.cellType,
            forCellReuseIdentifier: item.cellType.typeName
          )

          registeredTypes.insert(item.cellType.typeName)
        }
      }
    }
  }
}
