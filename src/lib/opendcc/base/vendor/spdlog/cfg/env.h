// Copyright(c) 2015-present, Gabi Melman & spdlog contributors.
// Distributed under the MIT License (http://opensource.org/licenses/MIT)

#pragma once
#include <opendcc/base/vendor/spdlog/cfg/helpers.h>
#include <opendcc/base/vendor/spdlog/details/os.h>
#include <opendcc/base/vendor/spdlog/details/registry.h>

//
// Init levels and patterns from env variables SPDLOG_LEVEL
// Inspired from Rust's "env_logger" crate (https://crates.io/crates/env_logger).
// Note - fallback to "info" level on unrecognized levels
//
// Examples:
//
// set global level to debug:
// export SPDLOG_LEVEL=debug
//
// turn off all logging except for logger1:
// export SPDLOG_LEVEL="*=off,logger1=debug"
//

// turn off all logging except for logger1 and logger2:
// export SPDLOG_LEVEL="off,logger1=debug,logger2=info"

namespace spdlog {
namespace cfg {
inline void load_env_levels() {
    auto env_val = details::os::getenv("SPDLOG_LEVEL");
    if (!env_val.empty()) {
        helpers::load_levels(env_val);
    }
}

}  // namespace cfg
}  // namespace spdlog
