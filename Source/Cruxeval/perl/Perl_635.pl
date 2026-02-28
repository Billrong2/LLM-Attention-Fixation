BEGIN {
    $ENV{LC_ALL} = 'C';
}

sub f {
    my($text) = @_;
    $text = uc($text);
    my @valid_chars = ('-', '_', '+', '.', '/', ' ');
    foreach my $char (split //, $text) {
        if ($char !~ /[[:alnum:]]/ && !grep {$_ eq $char} @valid_chars) {
            return "";
        }
    }
    return 1;
}


use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
