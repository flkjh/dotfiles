# vim
Vim settings and vim coloring.

## Remarks
I am just a pleb spending more and more time in terminal vim, and I like to tinker with key bindings, settings, coloring, etc...
All vim files are currently under development, so file version numbers of everything will be a key feature to keep track of everything when dev files are merged to master branch.
Currently I am using gruvbox, but the color scheme has gradually diverged to become a custom color scheme, so I feel the need to create my own color scheme.
Currently I have created some custom colors in xresources that terminal vim uses.

## TODO's
These are the upcoming todo's for my terminal vim experience..

### Syntax highlighting
Extend syntax highlighting for vim, bash, c, c++, java, go, python.
Add syntax highlighting for at least JS variants, Kotlin, Swift.

### Key combinations
Write vim libcall or use keyboard hooks to add more key combinations in vim.
I want to add plently more key combos for commands in vim, so I have started to tinker with these without much success at the moment.

First and foremost I want to add more modifier combos to work in terminal vim, which would mean using any combination of tab, caps, shift, ctrl, alt in normal mode and some of them in other modes. (will keep ctrl+key as it is, and will be careful with ctrl+alt+key to not intervene with terminal commands such as ctrl+c...)
The modifier combinations must work with space for me to be satisfied, meaning that combos such as shift+space, ctrl+space, ctrl+shift+space, etc.. should just be some examples of what it should be capable of.

The preference is that it should not be complicated to set up, and that the user should not need to tinker with xmodmaps or any of that kind.
This is the preference and might have to change in the future.
