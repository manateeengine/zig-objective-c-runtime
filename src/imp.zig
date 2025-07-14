//! Objective-C Runtime bindings for functions and typings that involve method implementations.

/// A pointer to the start of a method implementation.
///
/// ## Remarks
/// In the Objective-C runtime, this type is named `IMP`.
///
/// ## See
/// https://developer.apple.com/documentation/objectivec/imp?language=objc
pub const Imp = *const fn () callconv(.C) void;
