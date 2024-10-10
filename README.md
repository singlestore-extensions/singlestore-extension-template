# SingleStore Extension Template
## Overview

This repository automates the process of setting up a new project directory with predefined files and structures. It's designed to work with C++, C, and Rust projects, creating a consistent project layout and initializing necessary files with customized content.

## Features

- Creates a new project directory with subdirectories
- Copies template files to the new project directory
- Customizes files with project-specific information
- Supports C++, C, and Rust projects
- Cross-platform compatibility (Linux and macOS)

## Usage

```bash
./bootstrap.sh <target_folder> <year> <company> <project_name> <language>
```

### Arguments

1. `<target_folder>`: The directory where the new project will be created
2. `<year>`: The current year (for license information)
3. `<company>`: The company name (for license information)
4. `<project_name>`: The name of the project
5. `<language>`: The programming language for the project (cpp, c, or rust)

### Example

```bash
./bootstrap.sh ./my_new_project 2023 "Acme Inc." "Amazing Project" cpp
```

## Project Structure

The script creates the following structure in the target folder:

```
<target_folder>/
├── build/
│   ├── extension.wit
│   └── <project_name>.sql
├── src/
│   └── [language-specific source file]
├── LICENSE.md
├── README.md
├── CODE_OF_CONDUCT.md
├── Makefile
└── [Cargo.toml (for Rust projects only)]
```

## File Customization

The script performs the following customizations:

- Updates `LICENSE.md` with the provided year and company name
- Updates `README.md` with the project name
- Updates `Makefile` with the project name
- Renames `extension.sql` to `<project_name>.sql`

## Language-Specific Actions

Depending on the chosen language, the script will:

- Copy the appropriate Makefile
- Copy language-specific source files
- For Rust projects, copy `Cargo.toml`

## Cross-Platform Compatibility

The script uses a `sed_replace` function to handle differences between BSD sed (macOS) and GNU sed (Linux) for in-place file editing.

## Error Handling

The script includes basic error handling:

- Checks for the correct number of arguments
- Validates the language argument
- Provides usage information if arguments are incorrect

## Requirements

- Bash shell
- `sed` command-line utility
- Template files in the `./template_files/` directory

## Limitations

- The script assumes that all template files exist in the specified locations
- It does not create or modify any build system files beyond the Makefile
- The script does not handle complex project structures or dependencies

## Contributing

Contributions to improve the script or extend its functionality are welcome. Please submit pull requests or open issues on the project repository.