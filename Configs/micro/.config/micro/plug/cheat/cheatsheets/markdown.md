---
title: Markdown
category: Markup
layout: 2017/sheet
prism_languages: [markdown]
updated: 2020-07-01
weight: -1
---

## Reference
{:.-three-column}

### Headers

```markdown
# h1
## h2
### h3
#### h4
##### h5
###### h6
```

```markdown
Header 1
========
```

```markdown
Header 2
--------
```

### Emphasis

```markdown
*italic*
_italic_
```

```markdown
**bold**
__bold__
```

```markdown
***bold italic***
___bold italic___
```

```markdown
~~strikethrough~~
```

```markdown
`code`
```

### Lists

```markdown
* Item 1
* Item 2
```

```markdown
- Item 1
- Item 2
```

```markdown
- [ ] Checkbox off
- [x] Checkbox on
```

```markdown
1. Item 1
2. Item 2
```

### Links

```markdown
[link](http://google.com)
```

```markdown
[link][google]
[google]: http://google.com
```

```markdown
<http://google.com>
```

### Images

```markdown
![Image alt text](/path/to/img.jpg)
![Image alt text](/path/to/img.jpg "title")
![Image alt text][img]
```

```markdown
[img]: http://foo.com/img.jpg
```

### Code

```markdown
`inline code`
```

```
    4 space indent
    makes a code block
```

~~~markdown
```
code fences
```
~~~


~~~markdown
```js
codeFences.withLanguage()
```
~~~

### Blockquotes

```markdown
> This is
> a blockquote
>
> > Nested
> > Blockquote
```

### Horizontal line

```markdown
----
```

```markdown
****
```

### Tables

```markdown
| Column 1 Heading | Column 2 Heading |
| ---------------- | ---------------- |
| Some content     | Other content    |
```

```markdown
Column 1 Heading | Column 2 Heading
--- | ---
Some content | Other content
```

https://devhints.io/ cheatsheets - Copyright (c) 2021 Rico Sta. Cruz and contributors - MIT license
micro-cheat plugin Copyright 2022 Tero Karvinen https://TeroKarvinen.com/micro - MIT license
