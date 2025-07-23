//! Objective-C Runtime bindings for functions and typings that involve objects.

const std = @import("std");

/// @brief Represents an instance of a class.
///
/// @remarks The original name for this type in the Objective-C runtime is `objc_object`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_object)
pub const Object = extern struct {};

/// @brief A pointer to an instance of a class.
///
/// @details When you create an instance of a particular class, the allocated memory contains an
///          `Object` data structure, which is directly followed by the data for the instance
///          variables of the class.
///
///          The `alloc` and `allocWithZone:` methods of the Foundation framework class NSObject
///          use the function `classCreateInstance` to create `Object` data structures.
///
/// @remarks The original name for this type in the Objective-C runtime is `id`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/id)
pub const Id = *Object;
