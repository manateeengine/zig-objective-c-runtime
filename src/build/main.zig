//! Build logic for zig-objective-c-runtime. This is heavily inspired by Ghostty's build module,
//! and I highly recommend checking it out:
//! https://github.com/ghostty-org/ghostty/blob/main/src/build/main.zig.

pub const BuildConfig = @import("BuildConfig.zig");
pub const ExampleExe = @import("ExampleExe.zig");
pub const TestsExe = @import("TestsExe.zig");
pub const ZigObjectiveCRuntimeModule = @import("ZigObjectiveCRuntimeModule.zig");
