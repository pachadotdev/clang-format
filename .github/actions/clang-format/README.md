# Clang Format Multi-Version Action

A GitHub Action to format C/C++ code using multiple clang-format versions (11-19) with automatic commit capabilities.

## Features

- 🎯 **Multiple Versions**: Support for clang-format versions 11-19
- 🚀 **Fast**: Uses pre-built binaries (no compilation needed)
- 🔄 **Auto-commit**: Automatically commit formatted changes
- 📊 **Detailed Output**: Shows formatting statistics and changes
- 🛡️ **Flexible**: Can fail on formatting issues or auto-fix them
- 🌍 **Cross-platform**: Works on Ubuntu, macOS, and Windows runners

## Usage

### Basic Usage

```yaml
- uses: pachadotdev/clang-format@v1
```

### Format with specific version

```yaml
- uses: pachadotdev/clang-format@v1
  with:
    version: '14'
```

### Format specific files and auto-commit

```yaml
- uses: pachadotdev/clang-format@v1
  with:
    version: '18'
    files: 'src/*.cpp src/*.h'
    auto-commit: true
    commit-message: 'style: format C++ code with clang-format-18'
```

### Fail on formatting issues (PR checks)

```yaml
- uses: pachadotdev/clang-format@v1
  with:
    version: '19'
    fail-on-diff: true
    auto-commit: false
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `version` | Clang-format version to use (11-19) | No | `19` |
| `files` | Files or patterns to format | No | All C/C++ files |
| `auto-commit` | Auto-commit formatted changes | No | `true` |
| `commit-message` | Commit message for auto-commit | No | `style: auto-format code with clang-format` |
| `fail-on-diff` | Fail if formatting changes are needed | No | `false` |
| `working-directory` | Working directory to run in | No | `.` |

## Outputs

| Output | Description |
|--------|-------------|
| `files-changed` | Number of files that were changed |
| `has-changes` | Whether any files were changed (`true`/`false`) |

## Example Workflows

### Auto-format on push (recommended)

```yaml
name: Auto-format Code

on:
  push:
    branches: [ main, develop ]

jobs:
  format:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
      
      - uses: pachadotdev/clang-format@v1
        with:
          version: '18'
          auto-commit: true
          commit-message: 'style: auto-format C++ code'
```

### Format check on PR

```yaml
name: Format Check

on:
  pull_request:
    branches: [ main ]

jobs:
  format-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: pachadotdev/clang-format@v1
        with:
          version: '19'
          fail-on-diff: true
          auto-commit: false
```

### Multi-version format testing

```yaml
name: Format Test

on: [push, pull_request]

jobs:
  format-test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        clang-version: [14, 16, 18, 19]
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: pachadotdev/clang-format@v1
        with:
          version: ${{ matrix.clang-version }}
          fail-on-diff: true
          auto-commit: false
```

### Integration with R package workflow

```yaml
name: R-CMD-check

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  R-CMD-check:
    runs-on: ubuntu-latest
    
    steps:
      # Format C++ code first
      - uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
      
      - uses: pachadotdev/clang-format@v1
        with:
          version: '18'
          files: 'src/*.cpp src/*.h inst/include/*.h'
          auto-commit: true
          commit-message: 'style: format C++ code in R package'
      
      # Then run R package checks
      - uses: r-lib/actions/setup-pandoc@v2
      
      - uses: r-lib/actions/setup-r@v2
        with:
          r-version: 'release'
          use-public-rspm: true
      
      - uses: r-lib/actions/setup-r-dependencies@v2
        with:
          extra-packages: any::rcmdcheck
          needs: check
      
      - uses: r-lib/actions/check-r-package@v2
```

## Supported File Extensions

The action automatically detects and formats files with these extensions:
- `.cpp`, `.cc`, `.cxx` (C++ source)
- `.hpp`, `.h`, `.hxx` (C++ headers)
- `.c` (C source)

## Clang-format Versions

All versions use the LLVM style by default. Supported versions:
- clang-format-11 through clang-format-19
- Each version has different formatting rules and C++ standard support

## License

Apache 2.0 License - same as the LLVM project.
