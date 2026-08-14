#!/usr/bin/env bash
#
# setup-dev.sh
#
# Sets up a clean, opinionated ~/Dev directory structure for developers:
# University/Personal/Work separation, Forks, Playground, Archive,
# Templates, Courses, and Scripts — each with a README.md explaining
# its purpose and naming convention.
#
# Usage:
#   ./setup-dev.sh                # creates ~/Dev
#   ./setup-dev.sh ~/Code         # creates ~/Code instead
#   ./setup-dev.sh --dry-run      # show what would happen, don't write anything
#
set -euo pipefail

DRY_RUN=false
TARGET_DIR=""

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=true
      ;;
    -h|--help)
      echo "Usage: $0 [TARGET_DIR] [--dry-run]"
      echo "  TARGET_DIR   Where to create the dev structure (default: ~/Dev)"
      echo "  --dry-run    Print actions without creating anything"
      exit 0
      ;;
    *)
      TARGET_DIR="$arg"
      ;;
  esac
done

TARGET_DIR="${TARGET_DIR:-$HOME/Dev}"

run() {
  if $DRY_RUN; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

echo "Setting up dev directory at: $TARGET_DIR"
run mkdir -p "$TARGET_DIR"

SUBDIRS=(University Personal Work Forks Playground Archive Templates Courses Scripts)

for dir in "${SUBDIRS[@]}"; do
  run mkdir -p "$TARGET_DIR/$dir"
done

write_readme() {
  local path="$1"
  local content="$2"

  if $DRY_RUN; then
    echo "[dry-run] would write $path"
    return
  fi

  if [[ -f "$path" ]]; then
    echo "Skipping existing file: $path"
    return
  fi

  printf '%s\n' "$content" > "$path"
  echo "Created: $path"
}

write_readme "$TARGET_DIR/README.md" "# Dev

Root directory for everything development-related: projects, scripts,
experiments, third-party clones, and learning material. Not everything
here is a git repository — there may be notes, templates, or standalone
scripts too.

## Structure

- \`University/\` — university projects and coursework
- \`Personal/\` — personal projects, unrelated to work or school
- \`Work/\` — freelance work / clients
- \`Forks/\` — third-party repos cloned or forked
- \`Playground/\` — experiments and disposable test code
- \`Archive/\` — inactive projects kept but no longer touched
- \`Templates/\` — boilerplates for starting new projects
- \`Courses/\` — code from courses and tutorials
- \`Scripts/\` — general-purpose utility scripts (not tied to a project)

## Naming convention

- Project folders: \`kebab-case\` (e.g. \`weather-api\`, \`db-assignment-2\`)
- Each real project (with its own code) should have its own README.md"

write_readme "$TARGET_DIR/University/README.md" "# University

Projects, assignments, and coursework for university.

## What goes here
- Assignments and projects for each course
- Lab exercises
- Final course projects

## Convention
- Subfolder per course or semester, e.g. \`databases-2/\`, \`2025-2/\`
- Inside, one folder per assignment/project: \`kebab-case\`"

write_readme "$TARGET_DIR/Personal/README.md" "# Personal

Personal projects, unrelated to university or clients. This is where
things you build for fun or to seriously learn something live
(as opposed to Playground, which is disposable).

## What goes here
- Personal projects meant to be maintained
- Own tools for daily use

## Convention
- \`kebab-case\` per project
- If a project grows and gets serious, consider moving it to its own remote repo"

write_readme "$TARGET_DIR/Work/README.md" "# Work

Freelance work and client projects.

## What goes here
- One-off client projects
- Paid work

## Convention
- Subfolder per client: \`kebab-case\` (e.g. \`client-acme/\`)
- Inside each client, one folder per project if applicable"

write_readme "$TARGET_DIR/Forks/README.md" "# Forks

Third-party repositories cloned or forked to review, contribute to,
or use as reference. Not your own code.

## What goes here
- \`git clone\` of other people's repos
- Real forks (with your own remote) for making PRs

## Convention
- Keep the repo's original name (don't rename)"

write_readme "$TARGET_DIR/Playground/README.md" "# Playground

Experiments, quick tests, disposable code. Nothing here is
considered permanent.

## What goes here
- \"Let's see what happens if...\" tests
- Loose snippets to try out a library or idea

## Maintenance
- Consider running a periodic cleanup script here to delete old/unused content
- If something here turns out useful, move it to Personal/ or Templates/"

write_readme "$TARGET_DIR/Archive/README.md" "# Archive

Inactive projects no longer being developed but kept for reference
or historical value.

## What goes here
- Finished or abandoned projects from any other folder
- \"Just in case\" stuff you don't want to delete

## Convention
- Keep the project's original name
- Optional: prefix with year, e.g. \`2024-project-name/\`"

write_readme "$TARGET_DIR/Templates/README.md" "# Templates

Boilerplates and base templates for starting new projects quickly.

## What goes here
- Base project structures (e.g. \`template-react-vite/\`)
- Reusable configs (.eslintrc, generic .gitignore, etc.)

## Convention
- Prefix \`template-\` + technology/purpose, e.g. \`template-fastapi/\`"

write_readme "$TARGET_DIR/Courses/README.md" "# Courses

Code, exercises, and projects from external courses and tutorials
(not university).

## What goes here
- Exercises following an online course
- Guided tutorial projects

## Convention
- Subfolder per course/platform: \`kebab-case\`, e.g. \`udemy-advanced-react/\`"

write_readme "$TARGET_DIR/Scripts/README.md" "# Scripts

General-purpose utility scripts, not tied to any specific project.

## What goes here
- Personal automation scripts (bash, python, etc.)
- System utilities

## Convention
- Descriptive name in \`kebab-case\`, e.g. \`backup-dotfiles.sh\`
- If a script requires dependencies, document how to run it in a comment at the top"

echo ""
echo "Done. Review the result with:"
echo "  tree -L 2 --dirsfirst \"$TARGET_DIR\""
