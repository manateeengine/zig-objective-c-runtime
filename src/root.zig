//! Zig Objective-C Runtime: Idiomatic Zig Bindings for the Objective-C Runtime API.

const class = @import("class.zig");
const imp = @import("imp.zig");
const ivar = @import("ivar.zig");
const method = @import("method.zig");
const objc = @import("objc.zig");
const object = @import("object.zig");
const property = @import("property.zig");
const protocol = @import("protocol.zig");
const sel = @import("sel.zig");

pub const Class = class.Class;

pub const Id = object.Id;

pub const Imp = imp.Imp;

pub const Ivar = ivar.Ivar;

pub const Method = method.Method;

pub const Object = object.Object;

pub const Property = property.Property;

pub const Protocol = protocol.Protocol;

pub const Sel = sel.Sel;
pub const selGetName = sel.selGetName;
pub const selGetUid = sel.selGetUid;
pub const selIsEqual = sel.selIsEqual;
pub const selRegisterName = sel.selRegisterName;

test {
    _ = objc;
    _ = sel;
}
