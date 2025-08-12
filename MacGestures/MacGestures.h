//
//  MacGestures.h
//  MacGestures
//
//  Created by LE GALL Maxence on 12/08/2025.
//

#import <stdbool.h>

#if defined(__cplusplus)
extern "C" {
#endif

__attribute__((visibility("default")))
bool MacGestures_TryGetMagnifyDelta(float* outDelta);

__attribute__((visibility("default")))
bool MacGestures_TryGetPanDelta(float* outDeltaX, float* outDeltaY);

#if defined(__cplusplus)
}
#endif
