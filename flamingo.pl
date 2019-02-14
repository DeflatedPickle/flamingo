#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long qw(:config require_order auto_help);

# Credit: https://stackoverflow.com/a/4186180
sub longest {
    my $max = -1;

    for (@_) {
        if (length > $max) {
            $max = length;
        }
    }

    return $max;
}

my $indent = "                    ";
my $indent_small = "    ";

sub indent_string {
    my $text = "";

    foreach my $char (split(/\n/, $_[0])) {
        $text = $text . $_[1] . $char . "\n";
    }

    return $text;
}

sub craft_speech_bubble {
    # TODO: Handle new lines
    my @text = split(/\n/, $_[0]);
    # my $text = $_[0];

    my $speech_bubble = "";

    my $width = longest(@text) + 2;
    my $height = (scalar @text) + 2;

    my $triangle_start = $width >= 13 ? 13 : $width - 2;

    $indent_small = join("", (" ") x (length($indent) - $width));

    foreach my $y (0..$height + 1) {
        # print $y . "\n";

        my @split_text;
        # print $y, "\n---", scalar(@text), "\n";
        if ($y - 2 < scalar(@text) && scalar(@text) > 1) {
            @split_text = split(//, $text[$y - 2]);
        }
        elsif (scalar(@text) == 1) {
            @split_text = split(//, $text[0]);
        }
        else {
            @split_text = (" ") x $width;
        }

        foreach my $x (0..$width) {
            # print $x . "\n";

            # Top Left/Bottom Right
            if ($x == 0 && $y == 1 || $x == $width && $y == $height) {
                $speech_bubble = $speech_bubble . "/";
            }

            # Top Middle
            if ($x > 0 && $y == 0) {
                $speech_bubble = $speech_bubble . "_";
            }
            elsif ($x == 0 && $y == 0 || $x > 0 && $y == 1) {
                $speech_bubble = $speech_bubble . " ";
            }

            # Fill
            if ($x > 0 && $y > 1 && $x <= $width && $y < $height) {
                if ($x > 1 && $x - 2 < $width - 2) {
                    if (scalar(@split_text) >= $x - 1) {
                        $speech_bubble = $speech_bubble . $split_text[$x - 2];
                    }
                    else {
                        $speech_bubble = $speech_bubble . " ";
                    }
                }
                else {
                    $speech_bubble = $speech_bubble . " ";
                }
            }

            # Left Side/Right Side
            if ($x == 0 && $y > 1 && $y < $height || $x == $width && $y > 1 && $y < $height) {
                $speech_bubble = $speech_bubble . "|";
            }

            # Top Right/Bottom Left
            if ($x == $width && $y == 1 || $x == 0 && $y == $height) {
                $speech_bubble = $speech_bubble . "\\";
            }

            # Bottom Middle
            if ($x < $width - 2 && $x != $triangle_start - 1 && $x != $triangle_start && $y == $height) {
                $speech_bubble = $speech_bubble . "_";
            }
            elsif ($x >= $triangle_start - 1 && $x <= $triangle_start && $y == $height) {
                $speech_bubble = $speech_bubble . " ";
            }

            # Speech Triangle
            if ($x >= 0 && $x < $triangle_start + 1 && $y > $height && $y < $height + 3) {
                $speech_bubble = $speech_bubble . " ";
            }

            if ($x == $triangle_start && $y > $height && $y < $height + 2) {
                $speech_bubble = $speech_bubble . "\\";
            }

            if (($x == $triangle_start - 2 || $x == $triangle_start && $width > $triangle_start + 2) && $y > $height - 1 && $y < $height + 1) {
                $speech_bubble = $speech_bubble . ",";
            }

            if ($x == $triangle_start + 1 && $y > $height && $y < $height + 2) {
                $speech_bubble = $speech_bubble . "/";
            }
        }

        $speech_bubble = $speech_bubble . "\n";
    }

    return $speech_bubble;
}

# After walking into the editors' office,
# you see, upon the desk, a jar of eyes in front of you...
# Slowly, they all begin to twist and turn to look at you.
my @eyes = ('o', "O", '#', '+', '-', '*', '.', '~', '@', '\'', '"', "^", "_");

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
 /$  \
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

my $big_option = 0;
my $top_hat_option = 0;
# Get the options
GetOptions('big' => \$big_option, 'hat' => \$top_hat_option) or die;

# Get the input text
my $text;
if (@ARGV) {
    $text = join(' ', @ARGV);
    $text =~ s/\\n/\n/g;
}
else {
    my @pipe_input = ();
    foreach my $pipe (<>) {
        $pipe =~ s/^\s+|\s+$//g;
        $pipe =~ s/\\n/\n/g;
        push(@pipe_input, $pipe)
    }

    $text = join(' ', @pipe_input);
}

my $top_hat_chance;
if ($top_hat_option) {
    $top_hat_chance = 0;
}
else {
    $top_hat_chance = int(rand(42));
}

# This could have been done with an interpolated string,
# but I don't feel like doubling up on the backslashes
$flamingo_small =~ s/([\$])/$eyes[int(rand(scalar @eyes))]/g;

print indent_string(craft_speech_bubble($text), $indent_small);

# Print the text
if ($top_hat_chance == 0) {
    # print $flamingo_small_top_hat;
    if ($big_option) {
        print indent_string($flamingo_big_top_hat, $indent)
    }
    else {
        print indent_string($flamingo_small_top_hat, $indent)
    }
}
else {
    # print $flamingo_small_head;
    if ($big_option) {
        print indent_string($flamingo_big_head, $indent)
    }
    else {
        print indent_string($flamingo_small_head, $indent)
    }
}
# print $flamingo_small;
if ($big_option) {
    print indent_string($flamingo_big, $indent);
}
else {
    print indent_string($flamingo_small, $indent);
}
