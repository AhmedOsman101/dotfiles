---
title: zsh
category: CLI
layout: 2017/sheet
---

### Expressions

| Expression        | Example             | Description
| ---               | ---                 | ---
| `!!`              | `sudo !!`           | Last command (`sudo !!`)
| ---               | ---                 | ---
| `!*`              | `vim !*`            | Last command's parameters (`vim !*`)
| `!^`              |                     | Last command's first parameter
| `!$`              |                     | Last command's last parameter
| ---               | ---                 | ---
| `!?ls` `<tab>`    | `sudo !?mv` `<tab>` | Command and params of last `ls` command
| `!?ls?:*` `<tab>` |                     | Params of last `ls` command
| ---               | ---                 | ---
| `*(m0)`           | `rm *(m0)`          | Last modified today
| `*(m-4)`          |                     | Last modified <4 days ago
{: .-headers}

### Change default shell

```bash
chsh -s `which zsh`
```

### Process Substitution

| Expression        | Example                                               | Description
| ---               | ---                                                   | ---
| `<(COMMAND)`      | `grep "needle" <(curl "https://haystack.io")`         | Replace argument with _named pipe/FIFO_ (read-only) with command output
| `=(COMMAND)`      | `vim =(curl "https://haystack.io")`                   | Replace argument with _file_ (writable) containing command output
{: .-headers}

### Also see

- [Bash cheatsheet](./bash)

Zsh is mostly compatible with Bash, so most everything in Bash's cheatsheet also applies.

https://devhints.io/ cheatsheets - Copyright (c) 2021 Rico Sta. Cruz and contributors - MIT license
micro-cheat plugin Copyright 2022 Tero Karvinen https://TeroKarvinen.com/micro - MIT license
