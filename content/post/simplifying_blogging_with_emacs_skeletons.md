+++
title = "Simplifying blogging with emacs skeletons"
description = "How abbrev mode can speed things up"
date = 2016-01-29T18:08:23Z
tags = ["emacs","org","blogging","hugo"]
+++

One thing that hugo posts need is a frontmatter section that contains various metadata such as the post's title, description, date etc. It can be in various formats but they all get a bit tedious to keep typing out again manually.

Now, hugo can speed this up with archetypes (essentially post templates) but they won't work with [my org-mode setup](http://www.vurt.uk/post/blogging-with-emacs-and-hugo/) because I use a separate location for my org based content.

So to save myself some typing, I'm turning to emacs [abbrev mode](https://www.emacswiki.org/emacs/AbbrevMode) and [skeletons](http://www.emacswiki.org/emacs/SkeletonMode). A skeleton is essentially an interactive template that you define and abbrev mode lets you use an abbreviation that will expand out to that template.

The frontmatter skeleton I use is as follows:

```emacs-lisp
(define-skeleton skel-org-blog-frontmatter
  "Insert hugo frontmatter"
  "title:"
  "#+BEGIN_EXPORT md\n"
  "+++\n"
  "title = \"" str "\"\n"
  "description = \""_"\"\n"
  "date = \n"
  "tags = []\n"
  "+++\n"
  "#+END_EXPORT\n")
```

The `title:` section means that when this template is expanded, emacs will prompt me for some text in the minibuffer. This then gets inserted in place of the `str` marker.

The underscore indicates where the cursor will be placed when the template has been expanded.

In practice, this means that I'll get prompted for the title, which will be auto inserted and then the cursor will be placed in between the quotes of the description section, ready for me to type.

I'm sure it will be possible to have several text prompts, one for each of the fields, but I haven't investigated that yet.

Now in order to use the skeleton effectively, I have assigned an abbreviation that abbrev mode will use:

```emacs-lisp
(define-abbrev org-mode-abbrev-table "hugofront" "" 'skel-org-blog-frontmatter)
```

This means that I can type `hugofront` then abbrev mode will automatically replace it with the skeleton. Or if you don't have auto expansion enabled, `C-x a e` will expand the abbreviation at the cursor.

I've defined other skeletons for source code blocks in a similar manner.

All in all, this should hopefully save me some repetitive typing when creating blog posts.
