# 
sub f {
    my($messages) = @_;
    my $phone_code = "+353";
    my @result;
    for my $message (@$messages) {
        push @$message, split //, $phone_code;
        push @result, join ";", @$message;
    }
    return join ". ", @result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([["Marie", "Nelson", "Oscar"]]),"Marie;Nelson;Oscar;+;3;5;3")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
