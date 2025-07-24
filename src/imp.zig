//! Objective-C Runtime bindings for functions and typings that involve method implementations.

/// @brief A pointer to the start of a method implementation.
///
/// @details This data type is a pointer to the start of the function that implements the method.
///          This function uses standard C calling conventions as implemented for the current CPU
///          architecture. The first argument is a pointer to self (that is, the memory for the
///          particular instance of this class, or, for a class method, a pointer to the
///          metaclass). The second argument is the method selector. The method arguments follow.
///
/// @remarks The original name for this type in the Objective-C runtime is `IMP`.
///
/// @see [Objective-C Runtime Docs](https://developer.apple.com/documentation/objectivec/imp)
pub const Imp = *const fn () callconv(.c) void;
