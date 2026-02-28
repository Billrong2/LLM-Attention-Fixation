# 
use strict;

sub f {
    my($text) = @_;
    my @created;
    my @lines = split(/\n/, $text);
    foreach my $line (@lines) {
        if ($line eq '') {
            last;
        }
        my @line_chars = split(//, $line);
        my @reversed_line = reverse(@line_chars);
        push(@created, [splice(@reversed_line, 0, 1)]);
    }
    return [reverse(@created)];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("A(hiccup)A"),[["A"]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
