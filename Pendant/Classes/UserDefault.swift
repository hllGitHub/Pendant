//
//  UserDefault.swift
//  Pendant
//
//  Created by liangliang hu on 2022/2/15.
//

import Foundation

private protocol AnyOptional {
  var isNil: Bool { get }
}

extension Optional: AnyOptional {
  var isNil: Bool { self == nil }
}

@propertyWrapper
public struct UserDefault<Value> {
  public let key: String
  public let defaultValue: Value
  public var storage: UserDefaults = .standard

  public var wrappedValue: Value? {
    get {
      let value = storage.value(forKey: key) as? Value
      return value ?? defaultValue
    }
    set {
      if (newValue as AnyOptional).isNil {
        storage.removeObject(forKey: key)
      } else {
        storage.setValue(newValue, forKey: key)
      }
    }
  }

  public init(key: String, defaultValue: Value, storage: UserDefaults = .standard) {
    self.key = key
    self.defaultValue = defaultValue
    self.storage = storage
  }
}

@propertyWrapper
public struct UserDefaultCodable<Value: Codable> {
  let key: String
  let defaultValue: Value
  public var container: UserDefaults = .standard

  public var wrappedValue: Value {
    get {
      let data = container.data(forKey: key)
      let value = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
      return value ?? defaultValue
    }
    set {
      let data = try? JSONEncoder().encode(newValue)
      container.set(data, forKey: key)
      container.synchronize()
    }
  }
}
