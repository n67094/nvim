# Neovim Config

My personal neovim configuration shared mostly for me to be able to use it on any machine easily, but also for anyone else who might find it useful.

Used for programming in C, Lua and JavaScript using Git.

## Dependencies

Those deps should be installed using your package manager:

- universal-ctags (or alternative)
- ripgrep
- nnn

## Setup

Once everything is installed open neovim and run the following command:

```
:COQdeps
```

Followed by:

```
:COQnow
```

And finally, check that everything is working with correctly with:

```
:checkhealth lazy
```
