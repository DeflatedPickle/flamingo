# flamingo
A joke command.

## Description
It's a `cowsay` clone, written to practice Perl bad practices.

## Installing
I plan to upload it to Linix and Windows repositories (see #1)... when I learn how. Until then, it's a manual install.

## Example Usage
```
>perl flamingo.pl Hello, World!
     _______________
    /               \
    | Hello, World! |
    \____________,  /
                  \/
                      ___
                     /^  \
                    //--| |
                    ;   /,/
                      ,/ /   _/"""\
                      |  "\_/ /,   '\
                       \,      \_, \ \
                        `\____,--,\/ \;
                            ||\\    \;
                            || \\
                            || /,>
                            ||//
                            |//
                            //
                           //|
```
You can even pipe the flamingo into the flamingo, to make the flamingo say a flamingo saying a given phrase!
```
>perl flamingo.pl Hello, World! | perl flamingo.pl
     _________________________________________
    /                                         \
    |      _______________                    |
    |     /               \                   |
    |     | Hello, World! |                   |
    |     \____________,  /                   |
    |                   \/                    |
    |                       ___               |
    |                      /"  \              |
    |                     //--| |             |
    |                     ;   /,/             |
    |                       ,/ /   _/"""\     |
    |                       |  "\_/ /,   '\   |
    |                        \,      \_, \ \  |
    |                         `\____,--,\/ \; |
    |                             ||\\    \;  |
    |                             || \\       |
    |                             || /,>      |
    |                             ||//        |
    |                             |//         |
    |                             //          |
    |                            //|          |
    \____________,  ,_________________________/
                  \/
                      ___
                     /o  \
                    //--| |
                    ;   /,/
                      ,/ /   _/"""\
                      |  "\_/ /,   '\
                       \,      \_, \ \
                        `\____,--,\/ \;
                            ||\\    \;
                            || \\
                            || /,>
                            ||//
                            |//
                            //
                           //|
```
You can do this endlessly. Endlessly. END--LESS--LY!

## Usage Notes
- With each run, the eye used is random (from [this array](https://github.com/DeflatedPickle/flamingo/blob/55ee581c5112ea0606abd9b4d40ac0968bc874f3/flamingo.pl#L136)). This cannot be changed (see #3), sorry!
- The flamingo doesn't have [feet](https://github.com/DeflatedPickle/flamingo/blob/55ee581c5112ea0606abd9b4d40ac0968bc874f3/flamingo.pl#L215-L221). You can make it have feet by passing `-legs`
- You can make the flamingo wear a [fancy top hat](https://github.com/DeflatedPickle/flamingo/blob/55ee581c5112ea0606abd9b4d40ac0968bc874f3/flamingo.pl#L187-L192) with the flag `-hat`
- I spent hours writing a [big flamingo](https://github.com/DeflatedPickle/flamingo/blob/55ee581c5112ea0606abd9b4d40ac0968bc874f3/flamingo.pl#L153-L185) instead of doing school work, before realising it was too big and ugly for the terminal. You can use it, and support my wasted time, by passing `-big`

## Technical Notes
- Piping into `flamingo.pl` works, due to the code [here](https://github.com/DeflatedPickle/flamingo/blob/55ee581c5112ea0606abd9b4d40ac0968bc874f3/flamingo.pl#L238-L244), although I do not remember why it works
- Piping multi-line text works!
- Piping long text works, as long as your terminal is wide enough to show it, or it doesn't have word-wrap!
- When the given text is too long for the speach bubble, it will extend the speach bubble to the right without moving the flamingo
- Piping text from things like `echo` does work, though slightly broken (see #2)
