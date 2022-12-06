#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "OQS::oqs" for configuration "Debug"
set_property(TARGET OQS::oqs APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(OQS::oqs PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/oqs.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS OQS::oqs )
list(APPEND _IMPORT_CHECK_FILES_FOR_OQS::oqs "${_IMPORT_PREFIX}/lib/oqs.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
