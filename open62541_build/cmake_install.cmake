# Install script for directory: /home/omar/source/repos/open62541_bindings/open62541

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/omar/source/repos/open62541_bindings/open62541_build/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  MESSAGE(FATAL_ERROR "Installation with UA_ENABLE_AMALGAMATION=ON is not possible.")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so.1.4.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/omar/source/repos/open62541_bindings/open62541_build/bin/libopen62541.so.1.4.1"
    "/home/omar/source/repos/open62541_bindings/open62541_build/bin/libopen62541.so.1"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so.1.4.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/omar/source/repos/open62541_bindings/open62541_build/bin/libopen62541.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libopen62541.so")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/open62541" TYPE FILE FILES
    "/home/omar/source/repos/open62541_bindings/open62541_build/open62541Config.cmake"
    "/home/omar/source/repos/open62541_bindings/open62541/tools/cmake/open62541Macros.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/open62541" TYPE FILE FILES "/home/omar/source/repos/open62541_bindings/open62541_build/open62541ConfigVersion.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/open62541/open62541Targets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/open62541/open62541Targets.cmake"
         "/home/omar/source/repos/open62541_bindings/open62541_build/CMakeFiles/Export/8cb9d92d46a89e68bf96c40f4a60fffd/open62541Targets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/open62541/open62541Targets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/open62541/open62541Targets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/open62541" TYPE FILE FILES "/home/omar/source/repos/open62541_bindings/open62541_build/CMakeFiles/Export/8cb9d92d46a89e68bf96c40f4a60fffd/open62541Targets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/open62541" TYPE FILE FILES "/home/omar/source/repos/open62541_bindings/open62541_build/CMakeFiles/Export/8cb9d92d46a89e68bf96c40f4a60fffd/open62541Targets-debug.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/omar/source/repos/open62541_bindings/open62541_build/src_generated/open62541.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/open62541" TYPE DIRECTORY FILES
    "/home/omar/source/repos/open62541_bindings/open62541/tools/certs"
    "/home/omar/source/repos/open62541_bindings/open62541/tools/nodeset_compiler"
    FILES_MATCHING REGEX "/[^/]*$" REGEX "/\\_\\_pycache\\_\\_$" EXCLUDE REGEX "/[^/]*\\.pyc$" EXCLUDE REGEX "/\\.git[^/]*$" EXCLUDE PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/open62541/schema" TYPE DIRECTORY FILES "/home/omar/source/repos/open62541_bindings/open62541/tools/schema/" FILES_MATCHING REGEX "/[^/]*\\.xml$" REGEX "/[^/]*Types\\.bsd$" REGEX "/StatusCode\\.csv$" REGEX "/NodeIds\\.csv$" PERMISSIONS OWNER_READ GROUP_READ)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/open62541" TYPE FILE PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE FILES
    "/home/omar/source/repos/open62541_bindings/open62541/tools/generate_datatypes.py"
    "/home/omar/source/repos/open62541_bindings/open62541/tools/generate_nodeid_header.py"
    "/home/omar/source/repos/open62541_bindings/open62541/tools/generate_statuscode_descriptions.py"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/omar/source/repos/open62541_bindings/open62541_build/doc/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/omar/source/repos/open62541_bindings/open62541_build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
