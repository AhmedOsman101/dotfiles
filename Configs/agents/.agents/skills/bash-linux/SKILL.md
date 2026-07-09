---
name: bash-linux
description: "Bash/Linux terminal patterns. Critical commands, piping, error handling, scripting. Use when working on macOS, Linux, or any system with Bash/Zsh."
---

# Bash Linux Patterns

> Essential patterns for Bash on Linux/macOS.

---

## 1. Operator Syntax

### Chaining Commands

| Operator | Meaning                   | Example                             |
| -------- | ------------------------- | ----------------------------------- |
| `;`      | Run sequentially          | `cmd1; cmd2`                        |
| `&&`     | Run if previous succeeded | `pnpm install && pnpm run dev`        |
| `\|\|`   | Run if previous failed    | `pnpm test \|\| echo "Tests failed"` |
| `\|`     | Pipe output               | `ls \| rg ".js"`                    |

---

## 2. File Operations

### Essential Commands

| Task            | Command                                                                                      |
| --------------- | -------------------------------------------------------------------------------------------- |
| List all        | `eza --all --color=never --icons=never --long --no-time --no-user --group-directories-first` |
| Find files      | `fd . -e log ~/.local/share/opencode`                                                        |
| File content    | `cat file.txt`                                                                               |
| First N lines   | `head -n 20 file.txt`                                                                        |
| Last N lines    | `tail -n 20 file.txt`                                                                        |
| Follow log      | `tail -f log.txt`                                                                            |
| Search in files | `rg -iL "regex" *.js`                                                                        |
| File size       | `du -sh *`                                                                                   |
| Disk usage      | `df -h`                                                                                      |

---

## 3. Process Management

| Task           | Command                       |
| -------------- | ----------------------------- |
| List processes | `ps aux`                      |
| Find by name   | `ps aux \| rg -iN node`       |
| Kill by PID    | `kill -9 <PID>`               |
| Find port user | `lsof -i :3000`               |
| Kill port      | `kill -9 $(lsof -t -i :3000)` |
| Background     | `pnpm dev &`                  |
| Jobs           | `jobs -l`                     |
| Bring to front | `fg %1`                       |

---

## 4. Text Processing

### Core Tools

| Tool   | Purpose         | Example                            |
| ------ | --------------- | ---------------------------------- |
| `rg`   | Search          | `rg "TODO" src/`                   |
| `sed`  | Replace         | `sed -i 's\|old\|new\|g' file.txt` |
| `awk`  | Extract columns | `awk -F ' ' '{print $1}' file.txt` |
| `cut`  | Cut fields      | `cut -d',' -f1 data.csv`           |
| `sort` | Sort lines      | `sort -u file.txt`                 |
| `uniq` | Unique lines    | `sort file.txt \| uniq -c`         |
| `wc`   | Count           | `wc -l file.txt`                   |

---

## 5. Environment Variables

| Task                  | Command                                                                     |
| --------------------- | --------------------------------------------------------------------------- |
| View all (not secure) | `env` or `printenv`                                                         |
| View all (secure)     | `env \| rg -v 'api\|key\|secret'` or `printenv \| rg -v 'api\|key\|secret'` |
| View one              | `echo $PATH`                                                                |
| Set temporary         | `export VAR="value"`                                                        |
| Set in script         | `VAR="value" command`                                                       |
| Add to PATH           | `export PATH="$PATH:/new/path"`                                             |

---

## 6. Network

| Task         | Command                                                                     |
| ------------ | --------------------------------------------------------------------------- |
| Download     | `wget https://example.com/file`                                             |
| API request  | `curl -X GET https://api.example.com`                                       |
| POST JSON    | `curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' URL` |
| Check port   | `nc -zv localhost 3000`                                                     |
| Network info | `ip addr` or `ifconfig`                                                     |

---

## 7. Script Template

Use `mkscript -f script.sh` for a standard bash script in the selected path, `mkscript -t` to make a temporary script (lives in /tmp)

---

## 8. Common Patterns

### Check if command exists

```bash
if command -v node &> /dev/null; then
    echo "Node is installed"
fi
```

### Default variable value

```bash
NAME="${1:-"default_value"}"
```

### Read file line by line

```bash
while IFS= read -r line; do
    echo "${line}"
done < file.txt
```

### Loop over files

```bash
for file in *.js; do
    echo "Processing ${file}"
done
```

---

## 9. Differences from PowerShell

| Task          | PowerShell               | Bash                 |
| ------------- | ------------------------ | -------------------- |
| List files    | `Get-ChildItem`          | `ls -la`             |
| Find files    | `Get-ChildItem -Recurse` | `find . -type f`     |
| Environment   | `$env:VAR`               | `$VAR`               |
| String concat | `"$a$b"`                 | `"$a$b"` (same)      |
| Null check    | `if ($x)`                | `if [[ -n "${x}" ]]` |
| Pipeline      | Object-based             | Text-based           |

---

## 10. Error Handling

### Set options

```bash
set -e          # Exit on error
set -u          # Exit on undefined variable
set -o pipefail # Exit on pipe failure
set -x          # Debug: print commands
set +x          # Unset debug mode
```

### Trap for cleanup

```bash
cleanup() {
    echo "Cleaning up..."
    rm -f '/tmp/tempfile'
}
trap cleanup EXIT
```

---

> **Remember:** Bash is text-based. Use `&&` for success chains, `set -e` for safety, and quote your variables!

## When to Use

This skill is applicable to execute the workflow or actions described in the overview.

## Limitations

- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.
