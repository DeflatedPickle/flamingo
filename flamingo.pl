#!/usr/bin/perl
use strict;
use warnings;

# Occasionally a fancy flamingo
# TODO: Add a monocle
my $flamingo_big_top_hat = <<'END_TOP_HAT';
                           _______
                          |       |
                          |       |
                          |_______|
                         <_________>
END_TOP_HAT

# In case the hat isn't shown, there needs to be something else in it's place
my $flamingo_big_head = <<'END_HEAD';
                           ,/""""\
END_HEAD

my $flamingo_big = <<'END_FLAMINGO';
                          / #     \
                         /_,/---\  \
                        / //     \  \
                        |+|,     |  |
                         \\/     |  |
                          `     /  /
                               /  /
                              /  |           _,""""""""\_
                             |   \_        _/            \_
                             |     '\    _/  /,  ,         \_
                             |,      \__/     \;/\   ,       \
                              `\,                 \,/\   ,/\,/\
                                `\                    \,/      \
                                  \_\      ,_/ ,_/              \
                                    `\____/___/__/"""\___,      ,\
                                         || |  \, \,     `\_, \/\;
                                         |  |    \, \,      '\_;
                                         || |      \, \,
                                         | ||        \, \,
                                         |  |         _\, \,
                                         || |        <_  '>
                                         | ;|       ,/' ,/'
                                         <  >      ,/ ,/`
                                         |  |    ,/ ,/
                                         || |  ,/ ,/
                                         |__|,/ ,/
                                         | ,/  /'
                                         |/  /'
                                        ,/ ,/'
                                      ,/ ,/ |
                                    ,/  /|  |
END_FLAMINGO

my $flamingo_small_top_hat = <<'END_FLAMINGO_SMALL_HEAD';
                        ___
                       |   |
                       |___|
                      <_____>
END_FLAMINGO_SMALL_HEAD

my $flamingo_small_head = <<'END_FLAMINGO_SMALL_HEAD';
                        ___
END_FLAMINGO_SMALL_HEAD

my $flamingo_small = <<'END_FLAMINGO_SMALL';
                       /~  \
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
END_FLAMINGO_SMALL

my $flamingo_small_legs = <<'END_FLAMINGO_SMALL_LEGS';
                            //||
                           \| ||
                            | ||
                              ||
                             <--\
END_FLAMINGO_SMALL_LEGS

# Get the input text
my $text = <STDIN>;
chomp $text;

my $top_hat_chance = int(rand(42));

# Print the text
if ($top_hat_chance == 0) {
    print $flamingo_small_top_hat;
}
else {
    print $flamingo_small_head;
}
print $flamingo_small;
