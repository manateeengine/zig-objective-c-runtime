//! Objective-C Runtime bindings for functions and typings that involve objects.

/// Represents an instance of a class.
///
/// ## Remarks
/// In the Objective-C runtime, this type is named `objc_object`. The Objective-C runtime's docs
/// don't contain any information on the struct's properties, so it should be treated similarly to
/// an opaque type.
///
/// ## See
/// https://developer.apple.com/documentation/objectivec/objc_object?language=objc
pub const Object = extern struct {};

/// A pointer to an instance of a class.
///
/// ## See
/// https://developer.apple.com/documentation/objectivec/id?language=objc
pub const Id = *Object;
