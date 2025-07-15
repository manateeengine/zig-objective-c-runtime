//! Objective-C Runtime bindings for functions and typings that involve method selectors.

const std = @import("std");

/// Defines an opaque type that represents a method selector.
///
/// Original name: `SEL`
///
/// ## See
/// https://developer.apple.com/documentation/objectivec/sel?language=objc
pub const Sel = opaque {};

/// Returns the name of the method specified by a given selector.
///
/// Original name: `sel_getName`
///
/// ## Remarks
/// This function converts the original output from a C string to a Zig string literal slice.
///
/// ## See
/// https://developer.apple.com/documentation/objectivec/sel_getname(_:)?language=objc
pub fn selGetName(sel: *Sel) []const u8 {
    return std.mem.span(sel_getName(sel));
}

/// Registers a method name with the Objective-C runtime system.
///
/// Original name: `sel_getUid`
///
/// ## Remarks
/// This function converts the original output from a C string to a Zig string literal slice.
///
/// ## See
/// https://developer.apple.com/documentation/objectivec/sel_getuid(_:)?language=objc
pub fn selGetUid(sel: *Sel) []const u8 {
    return std.mem.span(sel_getUid(sel));
}

/// Returns a Boolean value that indicates whether two selectors are equal.
///
/// Original name: `sel_isEqual`
///
/// ## See
/// https://developer.apple.com/documentation/objectivec/sel_isequal(_:_:)?language=objc
pub fn selIsEqual(lhs: *Sel, rhs: *Sel) bool {
    return sel_isEqual(lhs, rhs);
}

/// Registers a method with the Objective-C runtime system, maps the method name to a selector, and
/// returns the selector value.
///
/// Original name: `sel_registerName`
///
/// ## See
/// https://developer.apple.com/documentation/objectivec/sel_registername(_:)?language=objc
pub fn selRegisterName(str: [*:0]const u8) *Sel {
    // const str_slice = str[0..str.len+1 :0];
    return sel_registerName(str);
}

extern "objc" fn sel_getName(sel: *Sel) callconv(.c) [*:0]const u8;
extern "objc" fn sel_getUid(sel: *Sel) callconv(.c) [*:0]const u8;
extern "objc" fn sel_isEqual(lhs: *Sel, rhs: *Sel) callconv(.c) bool;
extern "objc" fn sel_registerName(str: [*:0]const u8) callconv(.c) *Sel;

test selGetName {
    // It should return the provided method selector's name as a u8 slice
    const sel = selRegisterName("NSObject");
    try std.testing.expect(std.mem.eql(u8, selGetName(sel), "NSObject"));
}

test selGetUid {
    // It should register a method selector with the provided name
    const sel = selRegisterName("NSObject");
    try std.testing.expect(std.mem.eql(u8, selGetUid(sel), "NSObject1"));
}

test selIsEqual {
    // It should return true of the two provided method selectors are equal.
    const sel1 = selRegisterName("NSObject");
    const sel2 = selRegisterName("NSObject");
    const sel3 = selRegisterName("NSString");

    try std.testing.expect(selIsEqual(sel1, sel2));
    try std.testing.expect(selIsEqual(sel1, sel3) == false);
    try std.testing.expect(selIsEqual(sel2, sel3) == false);
}

test selRegisterName {
    // It should register a method selector with the provided name
    const sel = selRegisterName("NSObject");
    try std.testing.expect(std.mem.eql(u8, selGetName(sel), "NSObject"));
}
