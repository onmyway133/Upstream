import UIKit

/// Cell
public struct Item<T> {
  let model: T
  let cellType: UIView.Type

  public init(model: T, cellType: UIView.Type) {
    self.model = model
    self.cellType = cellType
  }
}
