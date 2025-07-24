//! Objective-C Runtime bindings for functions prefixed with `objc_`

const std = @import("std");
const Class = @import("class.zig").Class;
const Id = @import("object.zig").Id;
const Protocol = @import("protocol.zig").Protocol;
const sel = @import("sel.zig");

const Sel = sel.Sel;
const selRegisterName = sel.selRegisterName;

/// @brief Type to specify the behavior of an association.
///
/// @remarks The original name for this enum in the Objective-C runtime is
///          `objc_AssociationPolicy`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_associationpolicy)
pub const ObjcAssociationPolicy = enum(usize) {
    /// @brief Specifies an unsafe unretained reference to the associated object.
    ///
    /// @remarks The original name for this case in the Objective-C runtime is
    ///          `OBJC_ASSOCIATION_ASSIGN`.
    ///
    /// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_associationpolicy/objc_association_assign)
    objc_association_assign = 0,
    /// @brief Specifies a strong reference to the associated object, and that the association is
    ///        not made atomically.
    ///
    /// @remarks The original name for this case in the Objective-C runtime is
    ///          `OBJC_ASSOCIATION_RETAIN_NONATOMIC`.
    ///
    /// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_associationpolicy/objc_association_retain_nonatomic)
    objc_association_retain_nonatomic = 1,
    /// @brief Specifies that the associated object is copied, and that the association is not
    ///        made atomically.
    ///
    /// @remarks The original name for this case in the Objective-C runtime is
    ///          `OBJC_ASSOCIATION_COPY_NONATOMIC`.
    ///
    /// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_associationpolicy/objc_association_copy_nonatomic)
    objc_association_copy_nonatomic = 3,
    /// @brief Specifies a strong reference to the associated object, and that the association is
    ///        made atomically.
    ///
    /// @remarks The original name for this case in the Objective-C runtime is
    ///          `OBJC_ASSOCIATION_RETAIN`.
    ///
    /// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_associationpolicy/objc_association_retain)
    objc_association_retain = 769,
    /// @brief Specifies that the associated object is copied, and that the association is made
    ///        atomically.
    ///
    /// @remarks The original name for this case in the Objective-C runtime is
    ///          `OBJC_ASSOCIATION_COPY`.
    ///
    /// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_associationpolicy/objc_association_copy)
    objc_association_copy = 771,
};

/// @brief Creates a new class and metaclass.
///
/// @param superclass The class to use as the new class’s superclass, or `null` to create a new
///                   root class
///
/// @param name The string to use as the new class’s name. The string will be copied
///
/// @param extra_bytes The number of bytes to allocate for indexed ivars at the end of the class
///                    and metaclass objects. This should usually be `0`
///
/// @returns The new class, or `null` if the class could not be created (for example, the desired
///          name is already in use)
///
/// @details You can get a pointer to the new metaclass by calling `objectGetClass(newClass)`.
///          To create a new class, start by calling `objcAllocateClassPair`. Then set the class’s
///          attributes with functions like `classAddMethod` and `classAddIvar`. When you are done
///          building the class, call `objcRegisterClassPair`. The new class is now ready for use.
///          Instance methods and instance variables should be added to the class itself. Class
///          methods should be added to the metaclass.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_allocateClassPair`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_allocateclasspair(_:_:_:))
pub fn objcAllocateClassPair(superclass: ?*Class, name: [*:0]const u8, extra_bytes: usize) ?*Class {
    return objc_allocateClassPair(superclass, name, extra_bytes);
}

/// @brief Creates a new protocol instance.
///
/// @param name The name of the protocol you want to create
/// @returns A new protocol instance or `null` if a protocol with the same name as name already
///          exists
///
/// @details You must register the returned protocol instance with the `objcRegisterProtocol`
///          function before you can use it.
///
///          There is no dispose method associated with this function.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_allocateProtocol`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_allocateprotocol(_:)?language=objc)
pub fn objcAllocateProtocol(name: [*:0]const u8) ?*Protocol {
    return objc_allocateProtocol(name);
}

/// @brief Creates and returns a list of pointers to all registered class definitions.
///
/// @param out_count A `usize` pointer used to store the number of classes returned by this function
///                 in the list. This parameter may be `null`
///
/// @returns A `null` terminated array of classes. You must free the array with `free()`
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_copyClassList`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_copyclasslist(_:)?language=objc)
pub fn objcCopyClassList(out_count: ?*usize) [*]*Class {
    return objc_copyClassList(@ptrCast(out_count));
}

/// @brief Returns the names of all the classes within a specified library or framework.
///
/// @param image The library or framework you are inquiring about
///
/// @param out_count The number of class names in the returned array
///
/// @returns An array of C strings representing all of the class names within the specified library
///          or framework
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_copyClassNamesForImage`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_copyclassnamesforimage(_:_:)?language=objc)
pub fn objcCopyClassNamesForImage(image: [*:0]const u8, out_count: *usize) [*][*:0]const u8 {
    return objc_copyClassNamesForImage(image, @ptrCast(out_count));
}

/// @brief Returns the names of all the loaded Objective-C frameworks and dynamic libraries.
///
/// @param out_count The number of names in the returned array
///
/// @returns An array of C strings representing the names of all the loaded Objective-C frameworks
///          and dynamic libraries.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_copyImageNames`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_copyimagenames(_:)?language=objc)
pub fn objcCopyImageNames(out_count: *usize) [*][*:0]const u8 {
    return objc_copyImageNames(@ptrCast(out_count));
}

/// @brief Returns an array of all the protocols known to the runtime.
///
/// @param out_count Upon return, contains the number of protocols in the returned array
///
/// @returns A C array of all the protocols known to the runtime. The array contains `*outCount`
///          pointers followed by a `null` terminator. You must free the list with `free()`.
///
/// @details This function acquires the runtime lock.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_copyProtocolList`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_copyprotocollist(_:)?language=objc)
pub fn objcCopyProtocolList(out_count: *usize) [*]*Protocol {
    return objc_copyProtocolList(@ptrCast(out_count));
}

/// @brief Creates an instance of a class at the specified location.
///
/// @param cls The class that you want to allocate an instance of
///
/// @param bytes The location at which to allocate an instance of the cls class. bytes must point
///              to at least `classGetInstanceSize(cls)` bytes of well-aligned, zero-filled memory
///
/// @returns An instance of the class `cls` at `bytes`, if successful; otherwise `null` (for
///          example, if `cls` or `bytes` are themselves `null`)
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_constructInstance`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_constructinstance)
pub fn objcConstructInstance(cls: *Class, bytes: ?*anyopaque) ?Id {
    return objc_constructInstance(cls, bytes);
}

/// @brief Destroys an instance of a class without freeing memory and removes any of its associated
///        references.
///
/// @param obj The instance to destroy
///
/// @details This method does nothing if obj is `null`.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_destructInstance`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_destructinstance)
pub fn objcDestructInstance(obj: ?Id) void {
    return objc_destructInstance(obj);
}

/// @brief Destroys a class and its associated metaclass.
///
/// @param cls The class to be destroyed. This class must have been allocated using
///            `objcAllocateClassPair`
///
/// @details Do not call this function if instances of the cls class or any subclass exist.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_disposeClassPair`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_disposeclasspair(_:)?language=objc)
pub fn objcDisposeClassPair(cls: *Class) void {
    return objc_disposeClassPair(cls);
}

/// @brief Used by Foundation’s Key-Value Observing.
///
/// @param original The class to duplicate
///
/// @param name The name of the newly duplicated class
///
/// @param extra_bytes The number of bytes to allocate for indexed ivars at the end of the class
///                    objects. This should usually be `0`
///
/// @returns A duplicated class definition of a specified class
///
/// @details Do not call this function yourself.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_duplicateClass`. Param and return docs were written by-hand as they weren't
///          provided in the documentation.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_duplicateclass(_:_:_:)?language=objc)
pub fn objcDuplicateClass(original: ?*Class, name: [*:0]const u8, extra_bytes: usize) ?*Class {
    return objc_duplicateClass(original, name, extra_bytes);
}

/// @brief Inserted by the compiler when a mutation is detected during a foreach iteration.
///
/// @param obj The object being mutated
///
/// @details The compiler inserts this function when it detects that an object is mutated during a
///          foreach iteration. The function is called when a mutation occurs, and the enumeration
///          mutation handler is enacted if it is set up (via the
///          `objcSetEnumerationMutationHandler` function). If the handler is not set up, a fatal
///          error occurs.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_enumerationMutation`.
///
/// @todo This is currently untested, help with tests would be greatly appreciated.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_enumerationmutation(_:)?language=objc)
pub fn objcEnumerationMutation(obj: Id) void {
    return objc_enumerationMutation(obj);
}

/// @brief Returns the value associated with a given object for a given key.
///
/// @param object The source object for the association
///
/// @param key The key for the association
///
/// @returns The value associated with the key key for `object`
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_getAssociatedObject`.
///
/// @todo This is currently untested, help with tests would be greatly appreciated.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_getassociatedobject(_:_:)?language=objc)
pub fn objcGetAssociatedObject(object: Id, key: *const anyopaque) void {
    return objc_getAssociatedObject(object, key);
}

/// @brief Returns the class definition of a specified class.
///
/// @param name The name of the class to look up
///
/// @returns The Class object for the named class, or `null` if the class is not registered with
///          the Objective-C runtime.
///
/// @details The implementation of this function is identical to the implementation of the
///          `objcLookUpClass` function.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_getClass`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_getclass(_:)?language=objc)
pub fn objcGetClass(name: [*:0]const u8) ?*Class {
    return objc_getClass(name);
}

/// @brief Obtains the list of registered class definitions.
///
/// @param buffer An array of Class values. On output, each Class value points to one class
///               definition, up to either bufferCount or the total number of registered classes,
///               whichever is less. You can pass NULL to obtain the total number of registered
///               class definitions without actually retrieving any class definitions
///
/// @param buffer_count A `usize` value. Pass the number of pointers for which you have allocated
///                     space in buffer. On return, this function fills in only this number of
///                     elements. If this number is less than the number of registered classes,
///                     this function returns an arbitrary subset of the registered classes.
///
/// @returns A `usize` value indicating the total number of registered classes
///
/// @details The Objective-C runtime library automatically registers all the classes defined in
///          your source code. You can create class definitions at runtime and register them with
///          the `objcAddClass` function.
///
/// @warning You can’t assume that class objects you get from this function are classes that
///          inherit from `NSObject`, so you can’t safely call any methods on such classes without
///          detecting that the method is implemented first.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_getClassList`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_getclasslist(_:_:)?language=objc)
pub fn objcGetClassList(buffer: ?[*]*Class, buffer_count: usize) usize {
    return @intCast(objc_getClassList(buffer, @intCast(buffer_count)));
}

/// @brief Used by CoreFoundation’s toll-free bridging.
///
/// @param The name of the class to look up
///
/// @returns The class object for the named future class
///
/// @details Do not call this function yourself.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_getFutureClass`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_getfutureclass)
pub fn objcGetFutureClass(name: [*:0]const u8) *Class {
    return objc_getFutureClass(name);
}

/// @brief Returns the metaclass definition of a specified class.
///
/// @param name The name of the class to look up
///
/// @returns The `Class` object for the metaclass of the named class, or `null` if the class is not
///          registered with the Objective-C runtime
///
/// @details If the definition for the named class is not registered, this function calls the class
///          handler callback and then checks a second time to see if the class is registered.
///          However, every class definition must have a valid metaclass definition, and so the
///          metaclass definition is always returned, whether it’s valid or not.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_getMetaClass`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_getmetaclass(_:)?language=objc)
pub fn objcGetMetaClass(name: [*:0]const u8) ?*Class {
    return objc_getMetaClass(name);
}

/// @brief Returns a specified protocol.
///
/// @param name The name of a protocol
///
/// @returns The protocol named `name`, or `null` if no protocol named `name` could be found
///
/// @details This function acquires the runtime lock.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_getProtocol`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_getprotocol(_:)?language=objc)
pub fn objcGetProtocol(name: [*:0]const u8) ?*Protocol {
    return objc_getProtocol(name);
}

/// @brief Returns the class definition of a specified class.
///
/// @param name The name of the class to look up
///
/// @returns The Class object for the named class
///
/// @details This function is the same as objc_getClass, but kills the process if the class is not
///          found.
///          This function is used by ZeroLink, where failing to find a class would be a
///          compile-time link error without ZeroLink.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_getRequiredClass`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_getrequiredclass(_:)?language=objc)
pub fn objcGetRequiredClass(name: [*:0]const u8) *Class {
    return objc_getRequiredClass(name);
}

/// @brief Loads the object referenced by a weak pointer and returns it.
///
/// @param location The address of the weak pointer
///
/// @returns The object pointed to by location, or `null` if location is `null`
///
/// @details This function loads the object referenced by a weak pointer and returns it after
///          retaining and autoreleasing the object. As a result, the object stays alive long
///          enough for the caller to use it. This function is typically used anywhere a __weak
///          variable is used in an expression.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_loadWeak`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_loadweak(_:)?language=objc)
pub fn objcLoadWeak(location: *Id) ?*Id {
    return objc_loadWeak(location);
}

/// @brief Returns the class definition of a specified class.
///
/// @param name The name of the class to look up
///
/// @returns The Class object for the named class, or `null` if the class is not registered with
///          the Objective-C runtime
///
/// @details The implementation of this function is identical to the implementation of the
///          `objcGetClass` function.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_lookUpClass`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_lookupclass(_:)?language=objc)
pub fn objcLookUpClass(name: [*:0]const u8) ?*Class {
    return objc_lookUpClass(name);
}

/// @brief Sends a message with a simple return value to an instance of a class.
///
/// @param target A pointer that points to the instance of the class that is to receive the
///               message.
///
/// @param message The selector of the method that handles the message.
///
/// @param args The arguments to pass along with the message
///
/// @param ReturnType The message's response type
///
/// @returns The return value specified in `ReturnType`
///
/// @details When it encounters a method call, the compiler generates a call to `objc_msgSend`.
///          Messages sent to an object’s superclass (using the super keyword) are sent using
///          `objc_msgSendSuper`.
///
/// @warning This implementation does not work on Intel devices, only Apple Silicone is supported.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_msgSend`.
///
/// @todo Write up a comprehensive breakdown on why this function is so fucking weird and very
///       different from the params / return type presented in Apple's docs.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_msgsend)
pub fn objcMsgSend(target: *anyopaque, message: *Sel, args: anytype, ReturnType: type) ReturnType {
    const argsTypeInfo = @typeInfo((@TypeOf(args))).@"struct";
    std.debug.assert(argsTypeInfo.is_tuple); // Ensure provided args are a tuple

    // The first two params of a call to objc_msgSend are the target and the selector
    const ArgsParamsType: [argsTypeInfo.fields.len + 2]std.builtin.Type.Fn.Param = .{
        .{
            .is_generic = false,
            .is_noalias = false,
            .type = @TypeOf(target),
        },
        .{
            .is_generic = false,
            .is_noalias = false,
            .type = *Sel,
        },
    };

    // Add all remaining params

    for (argsTypeInfo.fields, 0..) |arg, i| {
        ArgsParamsType[i + 2] = .{
            .is_generic = false,
            .is_noalias = false,
            .type = arg.type,
        };
    }

    const FnType = @Type(.{ .@"fn" = .{
        .calling_convention = .c,
        .is_generic = false,
        .is_var_args = false,
        .return_type = ReturnType,
        .params = &ArgsParamsType,
    } });

    const msg_send_ptr: *const FnType = @ptrCast(&objc_msgSend);
    return @call(.auto, msg_send_ptr, .{ target, message } ++ args);
}

/// @brief Registers a class that was allocated using `objcAllocateClassPair`.
///
/// @param cls The class you want to register
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_registerClassPair`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_registerclasspair(_:)?language=objc)
pub fn objcRegisterClassPair(cls: *Class) void {
    return objc_registerClassPair(cls);
}

/// @brief Registers a newly created protocol with the Objective-C runtime.
///
/// @param proto The protocol you want to register with the Objective-C runtime
///
/// @details When you create a new protocol using the `objcAllocateProtocol`, you then register it
///          with the Objective-C runtime by calling this function. After a protocol is
///          successfully registered, it is immutable and ready to use.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_registerProtocol`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_registerprotocol(_:)?language=objc)
pub fn objcRegisterProtocol(proto: *Protocol) void {
    return objc_registerProtocol(proto);
}

/// @brief Removes all associations for a given object.
///
/// @param object An object that maintains associated objects
///
/// @details The main purpose of this function is to make it easy to return an object to a
///          “pristine state”. You should not use this function for general removal of associations
///          from objects, since it also removes associations that other clients may have added to
///          the object. Typically you should use `objcSetAssociatedObject` with a `null` value to
///          clear an association.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_removeAssociatedObjects`.
///
/// @todo This is currently untested, help with tests would be greatly appreciated.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_removeassociatedobjects(_:)?language=objc)
pub fn objcRemoveAssociatedObjects(object: Id) void {
    return objc_removeAssociatedObjects(object);
}

/// @brief Sets an associated value for a given object using a given key and association policy.
///
/// @param object The source object for the association
///
/// @param key The key for the association
///
/// @param value The value to associate with the key key for object. Pass `null` to clear an
///              existing association.
///
/// @param policy The policy for the association. For possible values, see `ObjcAssociationPolicy`.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_setAssociatedObject`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_setassociatedobject(_:_:_:_:)?language=objc)
pub fn objcSetAssociatedObject(object: Id, key: *const anyopaque, value: Id, policy: ObjcAssociationPolicy) void {
    return objc_setAssociatedObject(object, key, value, policy);
}

/// @brief Sets the current mutation handler.
///
/// @param handler A function pointer to the new mutation handler
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_setEnumerationMutationHandler`.
///
/// @todo This is currently untested, help with tests would be greatly appreciated.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_setenumerationmutationhandler(_:)?language=objc)
pub fn objcSetEnumerationMutationHandler(handler: *const fn (Id) callconv(.c) void) void {
    return objc_setEnumerationMutationHandler(handler);
}

/// @brief Sets the current mutation handler.
///
/// @param location The address of the weak pointer
///
/// @param obj The new object you want the weak pointer to now point to
///
/// @returns The value stored in `location` (that is, `obj`)
///
/// @details This function is typically used anywhere a __weak variable is the target of an
///          assignment.
///
/// @remarks The original name for this function in the Objective-C runtime is
///          `objc_setEnumerationMutationHandler`.
///
/// @todo This is currently untested, help with tests would be greatly appreciated.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/objc_storeweak(_:_:)?language=objc)
pub fn objcStoreWeak(location: *Id, obj: Id) Id {
    return objc_storeWeak(location, obj);
}

extern "objc" fn objc_allocateClassPair(superclass: ?*Class, name: [*:0]const u8, extra_bytes: usize) callconv(.c) ?*Class;
extern "objc" fn objc_allocateProtocol(name: [*:0]const u8) callconv(.c) ?*Protocol;
extern "objc" fn objc_copyClassList(out_count: ?*c_int) callconv(.c) [*]*Class;
extern "objc" fn objc_copyClassNamesForImage(image: [*:0]const u8, out_count: *c_int) [*][*:0]const u8;
extern "objc" fn objc_copyImageNames(out_count: *c_int) callconv(.c) [*][*:0]const u8;
extern "objc" fn objc_copyProtocolList(out_count: *c_int) callconv(.c) [*]*Protocol;
extern "objc" fn objc_constructInstance(cls: *Class, bytes: ?*anyopaque) ?Id;
extern "objc" fn objc_destructInstance(obj: ?Id) void;
extern "objc" fn objc_disposeClassPair(cls: *Class) callconv(.c) void;
extern "objc" fn objc_duplicateClass(original: *Class, name: [*:0]const u8, extra_bytes: usize) callconv(.c) void;
extern "objc" fn objc_enumerationMutation(obj: Id) callconv(.c) void;
extern "objc" fn objc_getAssociatedObject(object: Id, key: *const anyopaque) Id;
extern "objc" fn objc_getClass(name: [*:0]const u8) callconv(.c) ?*Class;
extern "objc" fn objc_getClassList(buffer: ?[*]*Class, buffer_count: c_int) callconv(.c) c_int;
extern "objc" fn objc_getFutureClass(name: [*:0]const u8) callconv(.c) *Class;
extern "objc" fn objc_getMetaClass(name: [*:0]const u8) callconv(.c) ?*Class;
extern "objc" fn objc_getProtocol(name: [*:0]const u8) callconv(.c) ?*Protocol;
extern "objc" fn objc_getRequiredClass(name: [*:0]const u8) callconv(.c) *Class;
extern "objc" fn objc_loadWeak(location: *Id) callconv(.c) ?Id;
extern "objc" fn objc_lookUpClass(name: [*:0]const u8) callconv(.c) ?*Class;
extern "objc" fn objc_msgSend() callconv(.c) void;
extern "objc" fn objc_registerClassPair(cls: *Class) callconv(.c) void;
extern "objc" fn objc_registerProtocol(proto: *Protocol) callconv(.c) void;
extern "objc" fn objc_removeAssociatedObjects(object: Id) callconv(.c) void;
extern "objc" fn objc_setAssociatedObject(object: Id, key: *const anyopaque, value: Id, policy: ObjcAssociationPolicy) callconv(.c) void;
extern "objc" fn objc_setEnumerationMutationHandler(handler: *const fn (Id) callconv(.c) void) callconv(.c) void;
extern "objc" fn objc_storeWeak(location: *Id, obj: Id) callconv(.c) Id;

test objcAllocateClassPair {
    // It should return a pointer to a Class if class creation succeeds
    const class = objcAllocateClassPair(null, "MyNewClass", 0);
    try std.testing.expect(@TypeOf(class.?) == *Class);

    // It should return null if class creation fails, such as when the class name is already in-use
    const already_allocated_class = objcAllocateClassPair(null, "NSObject", 0);
    try std.testing.expect(already_allocated_class == null);
}

test objcAllocateProtocol {
    // It should return a pointer to a Protocol if protocol creation succeeds
    const class = objcAllocateProtocol("MyNewProtocol");
    try std.testing.expect(@TypeOf(class.?) == *Protocol);

    // It should return null if protocol creation fails, such as when the protocol name is already
    // in-use
    const already_allocated_class = objcAllocateProtocol("NSObject");
    try std.testing.expect(already_allocated_class == null);
}

test objcCopyClassList {
    // It should return an array of classes
    var num_classes: usize = undefined;
    const list = objcCopyClassList(&num_classes);
    try std.testing.expect(num_classes > 1);
    try std.testing.expect(@TypeOf(list[0]) == *Class);
}

test objcCopyClassNamesForImage {
    // It should return an array of string literals
    var num_class_names: usize = undefined;
    const list = objcCopyClassNamesForImage("objc", &num_class_names);
    try std.testing.expect(num_class_names > 1);
    try std.testing.expect(@TypeOf(list[0]) == [*:0]const u8);
}

test objcCopyImageNames {
    // It should return an array of string literals
    var num_image_names: usize = undefined;
    const list = objcCopyImageNames(&num_image_names);
    try std.testing.expect(num_image_names > 1);
    try std.testing.expect(@TypeOf(list[0]) == [*:0]const u8);
}

test objcCopyProtocolList {
    // It should return an array of protocols
    var num_protocols: usize = undefined;
    const list = objcCopyProtocolList(&num_protocols);
    try std.testing.expect(num_protocols > 1);
    try std.testing.expect(@TypeOf(list[0]) == *Protocol);
}

test objcConstructInstance {
    // It should return a pointer to the class instance if creation was successful
    const class = objcGetClass("NSObject");
    const instance = objcConstructInstance(class.?, null); // Fails because bytes is null pointer

    // TODO: Figure out how to test success case
    try std.testing.expect(instance == null);
}

test objcDestructInstance {
    // It should destroy an instance of a class without freeing memory
    objcDestructInstance(null);

    // TODO: Figure out how to test success case
}

test objcDisposeClassPair {
    // It should remove the Class from the Objective-C runtime
    const class = objcAllocateClassPair(null, "MyNewClass", 0);
    objcRegisterClassPair(class.?);
    try std.testing.expect(objcGetClass("MyNewClass") != null);

    objcDisposeClassPair(class.?);
    try std.testing.expect(objcGetClass("MyNewClass") == null);
}

test objcEnumerationMutation {
    // TODO: I'm unsure how to test this
    _ = objcEnumerationMutation;
    std.log.warn("TODO: objcEnumerationMutation needs tests", .{});
}

test objcGetAssociatedObject {
    // TODO: I'm unsure how to test this
    _ = objcGetAssociatedObject;
    std.log.warn("TODO: objcGetAssociatedObject needs tests", .{});
}

test objcGetClass {
    // It should return a pointer to a Class if the Class has been registered with the runtime
    const class = objcGetClass("NSObject");
    try std.testing.expect(class != null);
    try std.testing.expect(@TypeOf(class.?) == *Class);

    // It should return null if the Class has not been registered with the runtime
    const classUnregistered = objcGetClass("SomeUnregisteredClass");
    try std.testing.expect(classUnregistered == null);
}

test objcGetClassList {
    // It should return the number of classes when buffer pointer is null
    var num_classes: usize = undefined;
    num_classes = objcGetClassList(null, 0);
    try std.testing.expect(num_classes > 1);

    // It should populate the buffer when buffer pointer is not null
    const class_list = try std.testing.allocator.alloc(*Class, @intCast(num_classes));
    defer std.testing.allocator.free(class_list);
    _ = objcGetClassList(class_list.ptr, num_classes);
    try std.testing.expect(@TypeOf(class_list[0]) == *Class);
}

test objcGetFutureClass {
    // It should return a pointer to a Class if the Class has been registered with the runtime
    const class = objcGetFutureClass("NSObject");
    try std.testing.expect(@TypeOf(class) == *Class);

    // It should return a pointer to a future Class even if the Class has not been registered with the runtime
    const classUnregistered = objcGetFutureClass("SomeUnregisteredClass");
    try std.testing.expect(@TypeOf(classUnregistered) == *Class);
}

test objcGetProtocol {
    // It should return a pointer to a Protocol if the Protocol has been registered with the runtime
    const protocol = objcGetProtocol("NSObject");
    try std.testing.expect(protocol != null);
    try std.testing.expect(@TypeOf(protocol.?) == *Protocol);

    // It should null if the Protocol has not been registered with the runtime
    const protocolUnregistered = objcGetProtocol("SomeUnregisteredProtocol");
    try std.testing.expect(protocolUnregistered == null);
}

test objcGetMetaClass {
    // It should return a pointer to a Class if the MetaClass has been registered with the runtime
    const class = objcGetMetaClass("NSObject");
    try std.testing.expect(class != null);
    try std.testing.expect(@TypeOf(class.?) == *Class);
}

test objcLoadWeak {
    // TODO: I'm unsure how to test this
    _ = objcLoadWeak;
    std.log.warn("TODO: objcLoadWeak needs tests", .{});
}

test objcLookUpClass {
    // It should return a pointer to a Class if the Class has been registered with the runtime
    const class = objcLookUpClass("NSObject");
    try std.testing.expect(class != null);
    try std.testing.expect(@TypeOf(class.?) == *Class);

    // It should return null if the Class not has been registered with the runtime
    const classUnregistered = objcLookUpClass("SomeUnregisteredClass");
    try std.testing.expect(classUnregistered == null);
}

test objc_msgSend {
    // It should send a message to the Objective-C runtime and return the message's response
    const objectGetClassName = @import("object.zig").objectGetClassName;
    const ns_object = objcGetClass("NSObject");
    const ns_object_instance = objcMsgSend(ns_object.?, selRegisterName("alloc"), .{}, Id);
    try std.testing.expect(@TypeOf(ns_object_instance) == Id);
    objcMsgSend(ns_object_instance, selRegisterName("init"), .{}, void);
    defer objcMsgSend(ns_object_instance, selRegisterName("release"), .{}, void);

    try std.testing.expect(std.mem.eql(u8, objectGetClassName(ns_object_instance).?, "NSObject"));
}

test objcGetRequiredClass {
    // It should return a pointer to a Class
    const class = objcGetRequiredClass("NSObject");
    try std.testing.expect(@TypeOf(class) == *Class);

    // Zig doesn't support testing panics yet, see https://github.com/ziglang/zig/issues/1356
}

test objcRegisterClassPair {
    // It should register the Class with the Objective-C runtime
    try std.testing.expect(objcGetClass("MyNewClass") == null);
    const class = objcAllocateClassPair(null, "MyNewClass", 0);
    try std.testing.expect(objcGetClass("MyNewClass") == null);
    objcRegisterClassPair(class.?);
    try std.testing.expect(objcGetClass("MyNewClass") != null);
}

test objcRegisterProtocol {
    // It should register the Protocol with the Objective-C runtime
    try std.testing.expect(objcGetProtocol("MyNewProtocol") == null);
    const protocol = objcAllocateProtocol("MyNewProtocol");
    try std.testing.expect(objcGetProtocol("MyNewProtocol") == null);
    objcRegisterProtocol(protocol.?);
    try std.testing.expect(objcGetProtocol("MyNewProtocol") != null);
}

test objcRemoveAssociatedObjects {
    // TODO: I'm unsure how to test this
    _ = objcRemoveAssociatedObjects;
    std.log.warn("TODO: objcRemoveAssociatedObjects needs tests", .{});
}

test objcSetAssociatedObject {
    // TODO: I'm unsure how to test this
    _ = objcSetAssociatedObject;
    std.log.warn("TODO: objcSetAssociatedObject needs tests", .{});
}

test objcSetEnumerationMutationHandler {
    // TODO: I'm unsure how to test this
    _ = objcSetEnumerationMutationHandler;
    std.log.warn("TODO: objcSetEnumerationMutationHandler needs tests", .{});
}

test objcStoreWeak {
    // TODO: I'm unsure how to test this
    _ = objcStoreWeak;
    std.log.warn("TODO: objcStoreWeak needs tests", .{});
}
