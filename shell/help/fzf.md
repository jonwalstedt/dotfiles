# Examples
? to open preview

## search for string and open file in vim (fif function in dotfiles)
vim $(fif mystring)

## cat output of fzf
cat $(fzf) <CR>

## Can select multiple processes with <TAB> or <Shift-TAB> keys
kill -9 <TAB>

#Search syntax
## Exact match, return items that include wild.
'wild
## Prefix-exact-match, return items that start with music.
^music
## Suffix-exact-match, return items that end with .mp3.
.mp3$
##Inverse-exact-match, return items that do not include fire.
!fire
## Inverse-prefix-exact-match, return items that do not start with music.
!^music
## Inverse-suffix-exact-match, return items that do not end with .mp3.
!.mp3$


### source
(boost)[https://medium.com/better-programming/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d]
