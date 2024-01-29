# Open62541 Dart Bindings - WIP
## Currently working

There is a raw example where read and subscribe are implemented.
currently only the read is functional.

## Notes

I am using the master branch of open62541 to have this commit https://github.com/open62541/open62541/pull/5445

When creating the build directory use -DUA_ENABLE_INLINABLE_EXPORT=ON to not expose the methods as static inline
otherwise the functions will be skipped.

complete command

Multithreading has to be off. We need to run open65421 periodically. Dart does not support multithreading.

## Create the .so file and the regenerate the bindings.
Create a directory to build open62541
```bash
mkdir open62541_build
```

Run this from the open62541_build directory
```bash
cmake ../open62541/ -DBUILD_SHARED_LIBS=ON -DUA_ENABLE_INLINABLE_EXPORT=ON -DCMAKE_INSTALL_PREFIX=install -DUA_BUILD_EXAMPLES=OFF -DUA_BUILD_UNIT_TESTS=OFF -DUA_ENABLE_AMALGAMATION=ON -DUA_MULTITHREADING=0
make
```

Now modify the open62541_build/open62541.h file, remove the bitfields from lines 23244-23250 and replace with a single byte.
In my experimentation I have added a static_assert and the size remains the same. I am not sure if this
will cause issues in the future but seems to generate a much larger section of the library.
Example of change
```patch
23244,23250c23244,23251
<     UA_Boolean    hasSymbolicId          : 1;
<     UA_Boolean    hasNamespaceUri        : 1;
<     UA_Boolean    hasLocalizedText       : 1;
<     UA_Boolean    hasLocale              : 1;
<     UA_Boolean    hasAdditionalInfo      : 1;
<     UA_Boolean    hasInnerStatusCode     : 1;
<     UA_Boolean    hasInnerDiagnosticInfo : 1;
---
>     // UA_Boolean    hasSymbolicId          : 1;
>     // UA_Boolean    hasNamespaceUri        : 1;
>     // UA_Boolean    hasLocalizedText       : 1;
>     // UA_Boolean    hasLocale              : 1;
>     // UA_Boolean    hasAdditionalInfo      : 1;
>     // UA_Boolean    hasInnerStatusCode     : 1;
>     // UA_Boolean    hasInnerDiagnosticInfo : 1;
>     UA_Byte          hasBitfield;
```

Then you can generate the bindings with
```bash
dart run ffigen
```

Some clang errors have been turned off to disable errors coming from macos's pthread library and other standard libraries
