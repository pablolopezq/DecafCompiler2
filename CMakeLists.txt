cmake_minimum_required (VERSION 2.6)
project (decaf)

set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -std=c++14" )

# Run bison to generate the parser
add_custom_command (
  OUTPUT decaf_parser.cpp decaf_tokens.h
  COMMAND bison -o parser.cpp --defines=tokens.h ${PROJECT_SOURCE_DIR}/src/decaf_parser.y
  MAIN_DEPENDENCY ${PROJECT_SOURCE_DIR}/src/decaf_parser.y
  )

# Run flex to generate the lexer
add_custom_command (
  OUTPUT decaf_lexer.cpp
  COMMAND flex -o decaf_lexer.cpp ${PROJECT_SOURCE_DIR}/src/decaf_lexer.l
  MAIN_DEPENDENCY ${PROJECT_SOURCE_DIR}/src/decaf_lexer.l
  )

#Run TreeCC to generate the AST Definition
add_custom_command (
  OUTPUT decaf_ast.cpp decaf_ast.h
  COMMAND treecc -o decaf_ast.cpp -h decaf_ast.h ${PROJECT_SOURCE_DIR}/src/decaf_ast.tc
  MAIN_DEPENDENCY ${PROJECT_SOURCE_DIR}/src/decaf_ast.tc
)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${PROJECT_SOURCE_DIR}/src/)

add_executable(decaf decaf_parser.cpp
                         decaf_lexer.cpp
                         decaf_ast.cpp 
                         ${PROJECT_SOURCE_DIR}/src/main.cpp)