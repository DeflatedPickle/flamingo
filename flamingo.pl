#!/usr/bin/perl
use strict;
use warnings;

my $text = <STDIN>;
chomp $text;

my $top_hat_chance = rand(60);

my $top_hat = << 'END_TOP_HAT';
           _______
          |       |
          |       |
          |_______|
         <_________>
END_TOP_HAT

my $flamingo_head = << 'END_FLAMINGO_HEAD';
           ,/""""\
END_FLAMINGO_HEAD

my $flamingo = << 'END_FLAMINGO';
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
             |       \__/     \;/\   ,       \
              `\                  \,/\   ,/\,/\
                `\                    \,/      \
                  \_\      ,_/ ,_/              \
                    `\____/___/__/"""\___       ,\
                         || |  \, \,     `\_  \/\;
                         |  |    \, \,      '\_;
                         || |      \, \,
                         || |        \, \,
                         |  |         _\, \,
                         || |        <_  '>
                         |; |       ,/' ,/'
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

if ($top_hat_chance == 0) {
    print $top_hat;
}
else {
    print $flamingo_head;
}
print $flamingo;
