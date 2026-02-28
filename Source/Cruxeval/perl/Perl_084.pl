# 
sub f {
    my($text) = @_;
    my @arr = split(' ', $text);
    my @result;
    foreach my $item (@arr) {
        if ($item =~ /day$/) {
            $item .= 'y';
        } else {
            $item .= 'day';
        }
        push @result, $item;
    }
    return join(' ', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("nwv mef ofme bdryl"),"nwvday mefday ofmeday bdrylday")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
