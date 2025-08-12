//
//  MacGestures.m
//  MacGestures
//
//  Created by LE GALL Maxence on 12/08/2025.
//

#import "MacGestures.h"
#import <Cocoa/Cocoa.h>

static float s_magnifyDelta = 0.0f;
static float s_panDeltaX = 0.0f, s_panDeltaY = 0.0f;

__attribute__((constructor))
static void InstallGestureMonitors(void) {
    [NSEvent addLocalMonitorForEventsMatchingMask:(NSEventMaskMagnify | NSEventMaskScrollWheel)
                                         handler:^NSEvent*(NSEvent *e){
        if (e.type == NSEventTypeMagnify) s_magnifyDelta += e.magnification;
        else if (e.type == NSEventTypeScrollWheel && e.hasPreciseScrollingDeltas) {
            s_panDeltaX += (float)e.scrollingDeltaX;
            s_panDeltaY += (float)e.scrollingDeltaY;
        }
        return e;
    }];
}

bool MacGestures_TryGetMagnifyDelta(float* outDelta) {
    if (!outDelta) return false;
    float d = s_magnifyDelta; s_magnifyDelta = 0.0f;
    if (fabsf(d) < 1e-4f) return false;
    *outDelta = d;
    return true;
}

bool MacGestures_TryGetPanDelta(float* outX, float* outY) {
    if (!outX || !outY) return false;
    float dx = s_panDeltaX, dy = s_panDeltaY;
    s_panDeltaX = s_panDeltaY = 0.0f;
    if (fabsf(dx) < 1e-3f && fabsf(dy) < 1e-3f) return false;
    *outX = dx; *outY = dy;
    return true;
}
