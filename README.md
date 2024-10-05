# Emacs C# WPF IDE

A minimalist Emacs-based IDE for C# and WPF development, optimized for Visual Studio 2019 integration.

## Overview

This repository provides a customized Emacs environment for C# and WPF development. It leverages Visual Studio 2019's tools while offering the power and flexibility of Emacs.

## Features

- Emacs configuration for C# and XAML editing
- Integration with Visual Studio 2019 tools (MSBuild, C# compiler, OmniSharp)
- Local package management and configuration
- Syntax highlighting, code completion, and error checking
- Basic XAML support

## Contents

- `.dir-locals.el`: Local Emacs configuration for C# and WPF development
- `Program.cs`: Sample C# program (from original repo)
- `SimpleCSharpProgram.csproj`: Sample project file
- `SimpleCSharpProgram.sln`: Sample solution file
- `compile.bat`: Batch script for command-line compilation (to be updated for Emacs usage)

## Prerequisites

- Emacs (recent version recommended)
- Visual Studio 2019 Professional (for MSBuild, C# compiler, and OmniSharp)

## Setup

1. Fork or clone this repository.
2. Ensure Visual Studio 2019 Professional is installed.
3. Open the project folder in Emacs.
4. Emacs will automatically install required packages and configure the environment based on `.dir-locals.el`.

## Usage

- Open `.cs` files to activate C# mode with OmniSharp integration.
- Use `C-c C-c` to compile (uses MSBuild).
- Navigate code with `C-c C-g` (go to definition) and other OmniSharp commands.
- Edit `.xaml` files with basic XML support (enhanced XAML support coming soon).

## Customization

Modify `.dir-locals.el` to adjust package lists, key bindings, or add new features.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the WTFPL - see [LICENSE](https://en.wikipedia.org/wiki/WTFPL) for details.

## Acknowledgements

Based on the [minimal-csharp-vs2019](https://github.com/MinimalWindowsDev/minimal-csharp-vs2019) repository.
