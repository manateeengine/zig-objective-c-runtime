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

pub const ObjcAssociationPolicy = objc.ObjcAssociationPolicy;
pub const objcAllocateClassPair = objc.objcAllocateClassPair;
pub const objcAllocateProtocol = objc.objcAllocateProtocol;
pub const objcCopyClassList = objc.objcCopyClassList;
pub const objcCopyClassNamesForImage = objc.objcCopyClassNamesForImage;
pub const objcCopyImageNames = objc.objcCopyImageNames;
pub const objcCopyProtocolList = objc.objcCopyProtocolList;
pub const objcConstructInstance = objc.objcConstructInstance;
pub const objcDestructInstance = objc.objcDestructInstance;
pub const objcDisposeClassPair = objc.objcDisposeClassPair;
pub const objcDuplicateClass = objc.objcDuplicateClass;
pub const objcEnumerationMutation = objc.objcEnumerationMutation;
pub const objcGetAssociatedObject = objc.objcGetAssociatedObject;
pub const objcGetClass = objc.objcGetClass;
pub const objcGetClassList = objc.objcGetClassList;
pub const objcGetFutureClass = objc.objcGetFutureClass;
pub const objcGetMetaClass = objc.objcGetMetaClass;
pub const objcGetProtocol = objc.objcGetProtocol;
pub const objcGetRequiredClass = objc.objcGetRequiredClass;
pub const objcLoadWeak = objc.objcLoadWeak;
pub const objcLookUpClass = objc.objcLookUpClass;
pub const objcMsgSend = objc.objcMsgSend;
pub const objcRegisterClassPair = objc.objcRegisterClassPair;
pub const objcRegisterProtocol = objc.objcRegisterProtocol;
pub const objcRemoveAssociatedObjects = objc.objcRemoveAssociatedObjects;
pub const objcSetAssociatedObject = objc.objcSetAssociatedObject;
pub const objcSetEnumerationMutationHandler = objc.objcSetEnumerationMutationHandler;
pub const objcStoreWeak = objc.objcStoreWeak;

pub const Object = object.Object;
pub const objectGetClassName = object.objectGetClassName;

pub const Property = property.Property;

pub const Protocol = protocol.Protocol;

pub const Sel = sel.Sel;
pub const selGetName = sel.selGetName;
pub const selGetUid = sel.selGetUid;
pub const selIsEqual = sel.selIsEqual;
pub const selRegisterName = sel.selRegisterName;

// Root files need to import all files with tests inside of a test block otherwise tests won't run
test {
    _ = objc;
    _ = object;
    _ = sel;
}
