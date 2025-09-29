# Clang-format Multi-version Builder
# This Makefile builds clang-format binaries for different LLVM versions
# Works on any Linux distribution with basic build tools

# Configuration
LLVM_VERSIONS = 11 12 13 14 15 16 17 18 19 20
BUILD_DIR = build
BIN_DIR = bin
INSTALL_PREFIX = $(PWD)/$(BIN_DIR)

# Build configuration
CMAKE_BUILD_TYPE = Release
JOBS = $(shell nproc)
MINIMAL_BUILD = 1

# Default target
.PHONY: all clean help clang11 clang12 clang13 clang14 clang15 clang16 clang17 clang18 clang19 clang20 status

all: $(addprefix $(BIN_DIR)/clang-format-, $(LLVM_VERSIONS))

help:
	@echo "Clang-format Multi-version Builder"
	@echo ""
	@echo "Available targets:"
	@echo "  all           - Build all clang-format versions"
	@echo "  clang11       - Build clang-format-11"
	@echo "  clang12       - Build clang-format-12"
	@echo "  clang13       - Build clang-format-13"  
	@echo "  clang14       - Build clang-format-14"
	@echo "  clang15       - Build clang-format-15"
	@echo "  clang16       - Build clang-format-16"
	@echo "  clang17       - Build clang-format-17"
	@echo "  clang18       - Build clang-format-18"
	@echo "  clang19       - Build clang-format-19"
	@echo "  clang20       - Build clang-format-20"
	@echo "  clean         - Clean all build artifacts"
	@echo ""
	@echo "Usage examples:"
	@echo "  make clang14                    # Build clang-format-14 (auto-installs deps + gcc14)"
	@echo "  make clang18                    # Build clang-format-18 (auto-installs deps)"
	@echo "  make all                        # Build all versions"
	@echo ""
	@echo "Build features:"
	@echo "  - Auto-installs dependencies (cmake, ninja, git, python3)"
	@echo "  - Auto-installs GCC 14 for LLVM 11-16 (better compatibility)"
	@echo "  - Builds only clang-format tool (not entire clang)"
	@echo "  - Minimal LLVM targets and disabled tests/docs for faster builds"
	@echo "  - Uses all CPU cores: $(JOBS)"
	@echo "  - C++14 for older LLVM versions (11-16) and C++20 for newer (17+)"

# Internal targets for dependency installation
install-build-deps-only:
	@if ! command -v cmake >/dev/null 2>&1 || ! command -v ninja >/dev/null 2>&1 || ! command -v git >/dev/null 2>&1; then \
		echo "📦 Installing build dependencies..."; \
		if command -v pacman >/dev/null 2>&1; then \
			sudo pacman -S --needed base-devel cmake git python ninja; \
		elif command -v apt-get >/dev/null 2>&1; then \
			sudo apt-get update && sudo apt-get install -y build-essential cmake git python3 ninja-build; \
		elif command -v dnf >/dev/null 2>&1; then \
			sudo dnf groupinstall -y "Development Tools" && sudo dnf install -y cmake git python3 ninja-build; \
		else \
			echo "❌ Package manager not supported. Please install: cmake, git, python3, ninja-build"; \
			exit 1; \
		fi; \
		echo "✅ Build dependencies installed"; \
	else \
		echo "✓ Build dependencies already installed"; \
	fi

install-build-deps-and-gcc14: install-build-deps-only
	@if ! command -v gcc-14 >/dev/null 2>&1; then \
		echo "📦 Installing GCC 14 for better LLVM 11-14 compatibility..."; \
		if command -v pacman >/dev/null 2>&1; then \
			sudo pacman -S --needed gcc14; \
		elif command -v apt-get >/dev/null 2>&1; then \
			sudo apt-get install -y gcc-14 g++-14; \
		elif command -v dnf >/dev/null 2>&1; then \
			sudo dnf install -y gcc-toolset-14-gcc gcc-toolset-14-gcc-c++; \
		else \
			echo "❌ GCC 14 auto-install not supported. Please install manually"; \
			exit 1; \
		fi; \
		echo "✅ GCC 14 installed successfully"; \
	else \
		echo "✓ GCC 14 already installed"; \
	fi

# Specific rules for building clang-format versions
clang11:
	@echo "🔨 Building clang-format-11 (auto-installing dependencies + GCC 14)..."
	@$(MAKE) install-build-deps-and-gcc14
	@$(MAKE) $(BIN_DIR)/clang-format-11
	@echo "✅ clang-format-11 build completed"

clang12:
	@echo "🔨 Building clang-format-12 (auto-installing dependencies + GCC 14)..."
	@$(MAKE) install-build-deps-and-gcc14
	@$(MAKE) $(BIN_DIR)/clang-format-12
	@echo "✅ clang-format-12 build completed"

clang13:
	@echo "🔨 Building clang-format-13 (auto-installing dependencies + GCC 14)..."
	@$(MAKE) install-build-deps-and-gcc14
	@$(MAKE) $(BIN_DIR)/clang-format-13
	@echo "✅ clang-format-13 build completed"

clang14:
	@echo "🔨 Building clang-format-14 (auto-installing dependencies + GCC 14)..."
	@$(MAKE) install-build-deps-and-gcc14
	@$(MAKE) $(BIN_DIR)/clang-format-14
	@echo "✅ clang-format-14 build completed"

clang15:
	@echo "🔨 Building clang-format-15 (auto-installing dependencies)..."
	@$(MAKE) install-build-deps-only
	@$(MAKE) $(BIN_DIR)/clang-format-15
	@echo "✅ clang-format-15 build completed"

clang16:
	@echo "🔨 Building clang-format-16 (auto-installing dependencies)..."
	@$(MAKE) install-build-deps-only
	@$(MAKE) $(BIN_DIR)/clang-format-16
	@echo "✅ clang-format-16 build completed"

clang17:
	@echo "🔨 Building clang-format-17 (auto-installing dependencies)..."
	@$(MAKE) install-build-deps-only
	@$(MAKE) $(BIN_DIR)/clang-format-17
	@echo "✅ clang-format-17 build completed"

clang18:
	@echo "🔨 Building clang-format-18 (auto-installing dependencies)..."
	@$(MAKE) install-build-deps-only
	@$(MAKE) $(BIN_DIR)/clang-format-18
	@echo "✅ clang-format-18 build completed"

clang19:
	@echo "🔨 Building clang-format-19 (auto-installing dependencies)..."
	@$(MAKE) install-build-deps-only
	@$(MAKE) $(BIN_DIR)/clang-format-19
	@echo "✅ clang-format-19 build completed"

clang20:
	@echo "🔨 Building clang-format-20 (auto-installing dependencies)..."
	@$(MAKE) install-build-deps-only
	@$(MAKE) $(BIN_DIR)/clang-format-20
	@echo "✅ clang-format-20 build completed"

$(BIN_DIR)/clang-format-%: | $(BIN_DIR)
	@echo "Building clang-format-$*..."
	@mkdir -p $(BUILD_DIR)/llvm-$*
	@if [ ! -d "$(BUILD_DIR)/llvm-project-$*" ]; then \
		echo "Downloading LLVM $*..."; \
		cd $(BUILD_DIR) && \
		if [ "$*" = "18" ] || [ "$*" = "19" ] || [ "$*" = "20" ]; then \
		  git clone --depth 1 --branch main https://github.com/llvm/llvm-project.git llvm-project-$*; \
		else \
		  ( \
		    git clone --depth 1 --branch llvmorg-$*.0.0 https://github.com/llvm/llvm-project.git llvm-project-$* 2>/dev/null || \
		    git clone --depth 1 --branch llvmorg-$*.1.0 https://github.com/llvm/llvm-project.git llvm-project-$* 2>/dev/null || \
		    git clone --depth 1 --branch llvmorg-$*.0.1 https://github.com/llvm/llvm-project.git llvm-project-$* 2>/dev/null || \
		    git clone --depth 1 --branch release/$*.x https://github.com/llvm/llvm-project.git llvm-project-$* 2>/dev/null || \
		    git clone --depth 1 --branch main https://github.com/llvm/llvm-project.git llvm-project-$* \
		  ); \
		fi; \
	fi
	@echo "Applying patches for LLVM $* compatibility..."
	@# Fix missing cstdint include in LLVM <= 13
	@if [ "$*" -le 13 ]; then \
		if ! grep -q '#include <cstdint>' $(BUILD_DIR)/llvm-project-$*/llvm/include/llvm/Support/Signals.h; then \
			sed -i '17a #include <cstdint>' $(BUILD_DIR)/llvm-project-$*/llvm/include/llvm/Support/Signals.h; \
			echo "✅ Added #include <cstdint> to Signals.h"; \
		fi; \
	fi
	@echo "Applying compatibility patches for LLVM $*..."
	@if [ "$*" = "11" ] || [ "$*" = "12" ] || [ "$*" = "13" ]; then \
		echo "Patching LLVM $* for modern compiler compatibility..."; \
		if [ -f "$(BUILD_DIR)/llvm-project-$*/llvm/include/llvm/Support/Signals.h" ]; then \
			grep -q "include <cstdint>" "$(BUILD_DIR)/llvm-project-$*/llvm/include/llvm/Support/Signals.h" || \
			sed -i '/#include <string>/a #include <cstdint>' "$(BUILD_DIR)/llvm-project-$*/llvm/include/llvm/Support/Signals.h"; \
		fi; \
	elif [ "$*" = "14" ] || [ "$*" = "15" ]; then \
		echo "Applying LLVM $* compatibility patches..."; \
		if [ -f "$(BUILD_DIR)/llvm-project-$*/llvm/include/llvm/Support/Signals.h" ]; then \
			grep -q "include <cstdint>" "$(BUILD_DIR)/llvm-project-$*/llvm/include/llvm/Support/Signals.h" || \
			sed -i '/#include <string>/a #include <cstdint>' "$(BUILD_DIR)/llvm-project-$*/llvm/include/llvm/Support/Signals.h"; \
		fi; \
		if [ -f "$(BUILD_DIR)/llvm-project-$*/llvm/lib/Support/Caching.cpp" ]; then \
			grep -q "include <functional>" "$(BUILD_DIR)/llvm-project-$*/llvm/lib/Support/Caching.cpp" || \
			sed -i '/#include "llvm\/Support\/Caching.h"/a #include <functional>' "$(BUILD_DIR)/llvm-project-$*/llvm/lib/Support/Caching.cpp"; \
		fi; \
	fi
	@echo "Configuring build for clang-format-$* (minimal build - only clang-format tool)..."
	@cd $(BUILD_DIR)/llvm-$* && \
	if [ "$*" -le "15" ]; then \
		echo "Using GCC 14 for LLVM $* (better compatibility with older LLVM)..."; \
		if command -v gcc-14 >/dev/null 2>&1 && command -v g++-14 >/dev/null 2>&1; then \
			CC_COMPILER=gcc-14; \
			CXX_COMPILER=g++-14; \
		else \
			echo "⚠️  GCC 14 not found. Install with: make install-gcc14"; \
			echo "Using default GCC with compatibility flags..."; \
			CC_COMPILER=gcc; \
			CXX_COMPILER=g++; \
		fi; \
		CXX_STD=17; \
		CXX_FLAGS="-std=c++17 -Wno-template-id-cdtor -Wno-deprecated-declarations -Wno-error -fpermissive -Wno-unused-parameter -Wno-unused-variable -D_GLIBCXX_USE_CXX11_ABI=0"; \
	elif [ "$*" -le "16" ]; then \
		echo "Using GCC 14 for LLVM $* (transitional version)..."; \
		if command -v gcc-14 >/dev/null 2>&1 && command -v g++-14 >/dev/null 2>&1; then \
			CC_COMPILER=gcc-14; \
			CXX_COMPILER=g++-14; \
		else \
			CC_COMPILER=gcc; \
			CXX_COMPILER=g++; \
		fi; \
		CXX_STD=17; \
		CXX_FLAGS="-std=c++17 -Wno-template-id-cdtor -Wno-deprecated-declarations -Wno-error -fpermissive"; \
	else \
		echo "Using default GCC for LLVM $* (modern version)..."; \
		CC_COMPILER=gcc; \
		CXX_COMPILER=g++; \
		CXX_STD=20; \
		CXX_FLAGS="-std=c++20 -Wno-deprecated-declarations"; \
	fi; \
	cmake -G Ninja \
		-DCMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_PREFIX) \
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
		-DCMAKE_C_COMPILER=$$CC_COMPILER \
		-DCMAKE_CXX_COMPILER=$$CXX_COMPILER \
		-DCMAKE_CXX_STANDARD=$$CXX_STD \
		-DCMAKE_CXX_FLAGS="$$CXX_FLAGS" \
		-DLLVM_ENABLE_PROJECTS=clang \
		-DLLVM_TARGETS_TO_BUILD="" \
		-DLLVM_ENABLE_RTTI=ON \
		-DLLVM_ENABLE_EH=ON \
		-DLLVM_BUILD_TOOLS=OFF \
		-DLLVM_BUILD_UTILS=OFF \
		-DLLVM_BUILD_RUNTIME=OFF \
		-DLLVM_BUILD_EXAMPLES=OFF \
		-DLLVM_BUILD_TESTS=OFF \
		-DLLVM_BUILD_DOCS=OFF \
		-DLLVM_INCLUDE_EXAMPLES=OFF \
		-DLLVM_INCLUDE_TESTS=OFF \
		-DLLVM_INCLUDE_DOCS=OFF \
		-DLLVM_INCLUDE_BENCHMARKS=OFF \
		-DCLANG_BUILD_TOOLS=ON \
		-DCLANG_BUILD_EXAMPLES=OFF \
		-DCLANG_BUILD_TESTS=OFF \
		-DCLANG_INCLUDE_DOCS=OFF \
		-DCLANG_INCLUDE_TESTS=OFF \
		-DCLANG_ENABLE_ARCMT=OFF \
		-DCLANG_ENABLE_STATIC_ANALYZER=OFF \
		-DCOMPILER_RT_BUILD_SANITIZERS=OFF \
		-DCOMPILER_RT_BUILD_XRAY=OFF \
		-DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
		-DCOMPILER_RT_BUILD_PROFILE=OFF \
		../llvm-project-$*/llvm
	@echo "Building clang-format-$* (this may take a while)..."
	@cd $(BUILD_DIR)/llvm-$* && \
	ninja clang-format -j$(JOBS)
	@echo "Installing clang-format-$*..."
	@cp $(BUILD_DIR)/llvm-$*/bin/clang-format $(BIN_DIR)/clang-format-$*
	@echo "✓ clang-format-$* built successfully"

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Format target - formats files in current directory
# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR)
	rm -rf $(BIN_DIR)
	@echo "✓ Clean complete"

# Show status of built binaries
status:
	@echo "Built clang-format binaries:"
	@for version in $(LLVM_VERSIONS); do \
		if [ -f "$(BIN_DIR)/clang-format-$$version" ]; then \
			echo "✓ clang-format-$$version: $$($(BIN_DIR)/clang-format-$$version --version)"; \
		else \
			echo "✗ clang-format-$$version: not built"; \
		fi; \
	done


