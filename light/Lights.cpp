/*
 * Copyright (C) 2019 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "Lights.h"

#include <android-base/logging.h>
#include <log/log.h>
#include <unistd.h>
#include <errno.h>

#include <aidl/android/hardware/light/LightType.h>
#include <aidl/android/hardware/light/FlashMode.h>

#define WARM_BACKLIGHT  "/sys/devices/platform/fe5c0000.i2c/i2c-3/3-0036/lm3630a_warm_light"
#define COLD_BACKLIGHT  "/sys/devices/platform/fe5c0000.i2c/i2c-3/3-0036/lm3630a_cold_light"

using namespace std;

namespace aidl {
namespace android {
namespace hardware {
namespace light {

static int write_int(const char* path, int value) {
    int fd;

    fd = open(path, O_RDWR);
    if (fd >= 0) {
        char buf[20];
        int bytes = snprintf(buf, sizeof(buf), "%d\n", value);
        ssize_t amt = write(fd, buf, (size_t)bytes);
        close(fd);
        return amt == -1? -errno : 0;
    } else {
        ALOGE("write_int() failed to open %s:%s\n", path, strerror(errno));
        return -errno;
    }
}

static int state2brightbess(const HwLightState& state) {
    int color = state.color;
    return ((77*((color>>16)&0x00ff))
            + (150*((color>>8)&0x00ff)) + (29*(color&0x00ff))) >> 8;
}

static int setLightFromType(LightType type, const HwLightState& state) {
    int err = 0;
    switch (type) {
        case LightType::BACKLIGHT: {
            int brightness = state2brightbess(state);
            err = write_int(WARM_BACKLIGHT, brightness);
            err += write_int(COLD_BACKLIGHT, brightness);
            break;
        }
        default:
            break;
    }
    if (err != 0) {
        ALOGE("Failed to setLightState: %d", err);
        return err;
    }
    return 0;
}

ndk::ScopedAStatus Lights::setLightState(int id, const HwLightState& state) {
    ALOGV("Lights setting state for id=%d to color:%x", id, state.color);
    LightType type;
    int err = -1;
    std::vector<HwLight>::iterator it = _lights.begin();
    for (; it != _lights.end(); ++it) {
        if (it->id == id) {
            type = it->type;
            err = 0;
            break;
        }
    }
    if (err != 0) {
        return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
    }
    // Set lights.
    err = setLightFromType(type, state);
    if (err == 0) {
        return ndk::ScopedAStatus::ok();
    }
    return ndk::ScopedAStatus::fromServiceSpecificError(err);
}

ndk::ScopedAStatus Lights::getLights(std::vector<HwLight>* lights) {
    ALOGI("Lights reporting supported lights");
    _lights.clear();
    addLight(0, LightType::BACKLIGHT);
    for (auto i = _lights.begin(); i != _lights.end(); i++) {
        lights->push_back(*i);
    }
    return ndk::ScopedAStatus::ok();
}


void Lights::addLight(int const ordinal, LightType const type) {
    HwLight light{};
    light.id = _lights.size();
    light.ordinal = ordinal;
    light.type = type;
    _lights.emplace_back(light);
}

}  // namespace light
}  // namespace hardware
}  // namespace android
}  // namespace aidl
