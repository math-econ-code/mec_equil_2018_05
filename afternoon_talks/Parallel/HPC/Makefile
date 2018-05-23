
# core compiling options

CXX_STD = -std=c++11
OPT_FLAGS = -Wall -O3 -march=native -ffp-contract=fast -DNDEBUG -DARMA_NO_DEBUG -fopenmp

# source directories
SDIR = .
HEADER_DIR = $(SDIR)/include

# shared library name and flags

ifeq ($(ARMA_INCLUDE_PATH),)
	ARMA_INCLUDE_PATH=$(HEADER_DIR)
endif

# general flags
CXXFLAGS = $(CXX_STD) $(OPT_FLAGS) -I$(ARMA_INCLUDE_PATH) -I$(HEADER_DIR)

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
	LIBS= -framework Accelerate
else
	LIBS= $(OPENBLAS_LINK_PATH) -lopenblas
endif

# core Optim files

SOURCES= ./coord_jacobi.cpp
OBJECTS= $(SOURCES:.cpp=.out)

all: $(OBJECTS)

#
$(SDIR)/%.out: $(SDIR)/%.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ $(LIBS)

# cleanup and install
.PHONY: clean
clean:
	@rm -f ./*.out ./*.o
