#!/usr/bin/perl
use strict;
use warnings;

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
    # my @text = split(/\n/, $_[0]);
    my $text = $_[0];

    my $speech_bubble = "";

    my $width = 16;
    my $height = 2;

    foreach my $y (0..$height + 4) {
        # print $y . "\n";

        my @split_text = split(//, $text);

        foreach my $x (0..$width) {
            # print $x . "\n";

            # Top Left/Bottom Right
            if ($x == 0 && $y == 0 || $x == $width && $y == $height) {
                $speech_bubble = $speech_bubble . "/";
            }

            # Top Middle
            if ($x > 0 && $y == 0) {
                $speech_bubble = $speech_bubble . "-";
            }

            # Fill
            if ($x > 0 && $y > 0 && $x <= $width && $y < $height) {
                if ($x > 1 && $x - 2 < int(length $text)) {
                    $speech_bubble = $speech_bubble . $split_text[$x - 2];
                }
                else {
                    $speech_bubble = $speech_bubble . " ";
                }
            }

            # Left Side/Right Side
            if ($x == 0 && $y > 0 && $y < $height || $x == $width && $y > 0 && $y < $height) {
                $speech_bubble = $speech_bubble . "|";
            }

            # Top Right/Bottom Left
            if ($x == $width && $y == 0 || $x == 0 && $y == $height) {
                $speech_bubble = $speech_bubble . "\\";
            }

            # Bottom Middle
            if ($x < $width - 3 && $y == $height) {
                $speech_bubble = $speech_bubble . "-";
            }
            elsif ($x > $width - 3 && $y == $height) {
                $speech_bubble = $speech_bubble . " ";
            }

            # Speech Triangle
            if ($x >= 0 && $x < $width - 1 && $y > $height && $y < $height + 3) {
                $speech_bubble = $speech_bubble . " ";
            }

            if ($x > $width - 3 && $x < $width - 1 && $y > $height && $y < $height + 2) {
                $speech_bubble = $speech_bubble . "\\";
            }

            if ($x > $width - 5 && $x < $width - 3 && $y > $height - 1 && $y < $height + 1) {
                $speech_bubble = $speech_bubble . ".";
            }

            if ($x == $width && $y > $height && $y < $height + 2) {
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
my @eyes = ('o', '#', '+', '-', '*', '.', '~');

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

# Get the input text
my $text = join(' ', @ARGV);

my $top_hat_chance = int(rand(42));

# This could have been done with an interpolated string,
# but I don't feel like doubling up on the backslashes
$flamingo_small =~ s/([\$])/$eyes[int(rand(scalar @eyes))]/g;

print indent_string(craft_speech_bubble( $text), $indent_small);

# Print the text
if ($top_hat_chance == 0) {
    # print $flamingo_small_top_hat;
    print indent_string($flamingo_small_top_hat, $indent)
}
else {
    # print $flamingo_small_head;
    print indent_string($flamingo_small_head, $indent)
}
# print $flamingo_small;
print indent_string($flamingo_small, $indent);
