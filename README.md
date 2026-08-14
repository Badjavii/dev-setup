<div align="center">

# Dev Setup

<!-- Subtitle -->
_Opinionated dev folder structure, one script away_

<!-- Badges -->
[![Tech](https://img.shields.io/badge/Tech-Bash-94e2d5?labelColor=181825&style=for-the-badge&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-f5c2e7?labelColor=181825&style=for-the-badge&logo=linux&logoColor=white)](https://www.linux.org/)
[![License](https://img.shields.io/github/license/Badjavii/dev-setup?color=a6e3a1&labelColor=181825&style=for-the-badge)](https://github.com/Badjavii/dev-setup/blob/main/LICENSE)

</div>

## About this project

**dev-setup** is a bash script that creates a clean, opinionated folder
structure for developers — separating personal projects, work/client
projects, university coursework, forks, templates and more — with a
`README.md` in every subdirectory explaining what belongs there and
which naming convention to follow.

No more dumping everything into a single `~/Projects` folder with 30
unrelated repos and zero criteria.

## Installation

```bash
git clone https://github.com/Badjavii/dev-setup.git
cd dev-setup
chmod +x setup-dev.sh
```

No dependencies. Just bash.

## Usage

```bash
./setup-dev.sh
```

By default this creates everything under `~/Dev`. To use a different
name or location:

```bash
./setup-dev.sh ~/Code
```

To preview what the script would do without touching anything:

```bash
./setup-dev.sh --dry-run
```

This creates the following structure, each with its own `README.md`:

```bash
Dev/
├── README.md
├── University/ # university projects and coursework
├── Personal/   # personal projects, unrelated to work or school
├── Work/       # freelance work / clients
├── Forks/      # third-party repos cloned or forked
├── Playground/ # experiments and disposable test code
├── Archive/    # inactive projects kept but no longer touched
├── Templates/  # boilerplates for starting new projects
├── Courses/    # code from courses and tutorials
└── Scripts/    # general-purpose utility scripts
```

## Notes

- The script is idempotent for the READMEs: if a file already exists,
  it won't be overwritten, so you won't lose your own edits if you
  run it again.
- Uses `set -euo pipefail`, so if something fails it stops instead of
  leaving the structure half-built in silence.
- Verify the result anytime with `tree -L 2 --dirsfirst ~/Dev`.

## Credits

This project is proudly designed and developed by **Badjavii**, junior developer.
