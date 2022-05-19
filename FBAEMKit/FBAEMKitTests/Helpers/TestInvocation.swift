/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

@testable import FBAEMKit
import Foundation

@objcMembers
final class TestInvocation: _AEMInvocation {

  var attributionCallCount = 0
  var updateConversionCallCount = 0
  var isOptimizedEvent = false
  var shouldBoostPriority = false

  // This was copied from the superclass because the superclass version can't be called from a subclass
  convenience init?(
    campaignID: String,
    acsToken: String,
    acsSharedSecret: String?,
    acsConfigID: String?,
    businessID: String?,
    catalogID: String?,
    isTestMode: Bool,
    hasSKAN: Bool,
    isConversionFilteringEligible: Bool
  ) {
    self.init(
      campaignID: campaignID,
      acsToken: acsToken,
      acsSharedSecret: acsSharedSecret,
      acsConfigID: acsConfigID,
      businessID: businessID,
      catalogID: catalogID,
      timestamp: nil,
      configMode: "DEFAULT",
      configID: -1,
      recordedEvents: nil,
      recordedValues: nil,
      conversionValue: -1,
      priority: -1,
      conversionTimestamp: nil,
      isAggregated: true,
      isTestMode: isTestMode,
      hasSKAN: hasSKAN,
      isConversionFilteringEligible: isConversionFilteringEligible
    )
  }

  override func attributeEvent(
    _ event: String,
    currency: String?,
    value: NSNumber?,
    parameters: [String: Any]?,
    configurations: [String: [_AEMConfiguration]]?,
    shouldUpdateCache: Bool
  ) -> Bool {
    attributionCallCount += 1
    return true
  }

  override func updateConversionValue(
    configurations configs: [String: [_AEMConfiguration]]?,
    event: String,
    shouldBoostPriority: Bool
  ) -> Bool {
    updateConversionCallCount += 1
    self.shouldBoostPriority = shouldBoostPriority
    return true
  }

  override func isOptimizedEvent(
    _ event: String,
    configurations: [String: [_AEMConfiguration]]?
  ) -> Bool {
    isOptimizedEvent
  }
}
