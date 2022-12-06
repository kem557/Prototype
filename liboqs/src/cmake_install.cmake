# Install script for directory: D:/Users/charl/Source/liboqs/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "D:/Users/charl/Source/liboqs/out/install/x64-Debug")
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

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/liboqs" TYPE FILE FILES
    "D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/liboqsConfig.cmake"
    "D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/liboqsConfigVersion.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/Users/charl/Source/liboqs/out/build/x64-Debug/lib/oqs.lib")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/liboqs/liboqsTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/liboqs/liboqsTargets.cmake"
         "D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/CMakeFiles/Export/lib/cmake/liboqs/liboqsTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/liboqs/liboqsTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/liboqs/liboqsTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/liboqs" TYPE FILE FILES "D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/CMakeFiles/Export/lib/cmake/liboqs/liboqsTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/liboqs" TYPE FILE FILES "D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/CMakeFiles/Export/lib/cmake/liboqs/liboqsTargets-debug.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/oqs" TYPE FILE FILES
    "D:/Users/charl/Source/liboqs/src/oqs.h"
    "D:/Users/charl/Source/liboqs/src/common/common.h"
    "D:/Users/charl/Source/liboqs/src/common/rand/rand.h"
    "D:/Users/charl/Source/liboqs/src/common/aes/aes.h"
    "D:/Users/charl/Source/liboqs/src/common/sha2/sha2.h"
    "D:/Users/charl/Source/liboqs/src/common/sha3/sha3.h"
    "D:/Users/charl/Source/liboqs/src/common/sha3/sha3x4.h"
    "D:/Users/charl/Source/liboqs/src/kem/kem.h"
    "D:/Users/charl/Source/liboqs/src/sig/sig.h"
    "D:/Users/charl/Source/liboqs/src/kem/frodokem/kem_frodokem.h"
    "D:/Users/charl/Source/liboqs/src/sig/picnic/sig_picnic.h"
    "D:/Users/charl/Source/liboqs/src/kem/classic_mceliece/kem_classic_mceliece.h"
    "D:/Users/charl/Source/liboqs/src/kem/hqc/kem_hqc.h"
    "D:/Users/charl/Source/liboqs/src/kem/kyber/kem_kyber.h"
    "D:/Users/charl/Source/liboqs/src/kem/ntru/kem_ntru.h"
    "D:/Users/charl/Source/liboqs/src/kem/ntruprime/kem_ntruprime.h"
    "D:/Users/charl/Source/liboqs/src/kem/saber/kem_saber.h"
    "D:/Users/charl/Source/liboqs/src/sig/dilithium/sig_dilithium.h"
    "D:/Users/charl/Source/liboqs/src/sig/falcon/sig_falcon.h"
    "D:/Users/charl/Source/liboqs/src/sig/rainbow/sig_rainbow.h"
    "D:/Users/charl/Source/liboqs/src/sig/sphincs/sig_sphincs.h"
    "D:/Users/charl/Source/liboqs/out/build/x64-Debug/include/oqs/oqsconfig.h"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/common/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/kem/frodokem/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/sig/picnic/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/kem/classic_mceliece/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/kem/hqc/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/kem/kyber/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/kem/ntru/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/kem/ntruprime/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/kem/saber/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/sig/dilithium/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/sig/falcon/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/sig/rainbow/cmake_install.cmake")
  include("D:/Users/charl/Source/liboqs/out/build/x64-Debug/src/sig/sphincs/cmake_install.cmake")

endif()

