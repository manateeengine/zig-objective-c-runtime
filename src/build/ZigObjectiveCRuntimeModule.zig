//! A struct that creates and configures a Zig module for zig-objective-c-runtime.

const std = @import("std");
const BuildConfig = @import("BuildConfig.zig");

const ZigObjectiveCRuntimeModule = @This();

/// The primary zig-objective-c-runtime module
module: *std.Build.Module,

/// Initializes a new ZigObjectiveCRuntimeModule struct with the provided BuildConfig.
pub fn init(b: *std.Build, build_config: *const BuildConfig) ZigObjectiveCRuntimeModule {
    const module = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .optimize = build_config.optimize,
        .target = build_config.target,
    });

    return ZigObjectiveCRuntimeModule{
        .module = module,
    };
}
