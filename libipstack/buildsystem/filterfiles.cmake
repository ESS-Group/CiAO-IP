cmake_minimum_required (VERSION 2.8.8)

function(filter_files_cpp out_var)
  set(result)
  foreach(file ${ARGN})
    get_filename_component (extension "${file}" EXT)
    string(TOUPPER "${extension}" extension)
    if ("${extension}" STREQUAL ".CPP" OR "${extension}" STREQUAL ".CC" OR "${extension}" STREQUAL ".CXX")
		list(APPEND result ${file})
	endif()
  endforeach()
  set(${out_var} "${result}" PARENT_SCOPE)
endfunction()

function(filter_files_two out_var filter_extension out_var2 filter_extension2)
  set(result)
  set(result2)
  string(TOUPPER "${filter_extension}" filter_extension)
  string(TOUPPER "${filter_extension2}" filter_extension2)
  foreach(file ${ARGN})
    get_filename_component (extension "${file}" EXT)
    string(TOUPPER "${extension}" extension)
    if ("${extension}" STREQUAL "${filter_extension}")
		list(APPEND result ${file})
	endif()
    if ("${extension}" STREQUAL "${filter_extension2}")
		list(APPEND result2 ${file})
	endif()
  endforeach()
  set(${out_var} "${result}" PARENT_SCOPE)
  set(${out_var2} "${result2}" PARENT_SCOPE)
endfunction()