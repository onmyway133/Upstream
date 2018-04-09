import UIKit

/// Cell
public struct Item {
  let model: Any
  let cellType: UIView.Type

  public init(model: Any, cellType: UIView.Type) {
    self.model = model
    self.cellType = cellType
  }
}
