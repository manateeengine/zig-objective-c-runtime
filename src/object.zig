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
///          The `alloc` and `allocWithZone:` methods of the Foundation framework class NSObject
///          use the function `classCreateInstance` to create `Object` data structures.
///
/// @remarks The original name for this type in the Objective-C runtime is `id`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/id)
pub const Id = *Object;

/// @brief Returns the class name of a given object.
///
/// @param str An Objective-C object
///
/// @returns The name of the class of which `obj` is an instance
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `object_getClassName`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/object_getclassname(_:))
pub fn objectGetClassName(obj: Id) ?[]const u8 {
    const class_name = object_getClassName(obj);
    if (class_name == null) {
        return null;
    }
    return std.mem.span(class_name.?);
}

extern "objc" fn object_getClassName(obj: Id) callconv(.c) ?[*:0]const u8;

test {
    const objc = @import("objc.zig");
    const selRegisterName = @import("sel.zig").selRegisterName;

    const ns_object = objc.objcGetClass("NSObject");
    const ns_object_instance = objc.objcMsgSend(ns_object.?, selRegisterName("alloc"), .{}, Id);
    try std.testing.expect(@TypeOf(ns_object_instance) == Id);
    objc.objcMsgSend(ns_object_instance, selRegisterName("init"), .{}, void);
    defer objc.objcMsgSend(ns_object_instance, selRegisterName("release"), .{}, void);

    try std.testing.expect(std.mem.eql(u8, objectGetClassName(ns_object_instance).?, "NSObject"));
}
