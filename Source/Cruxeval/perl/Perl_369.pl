# 
sub f {
    my($var) = @_;
    if ($var =~ /^\d+$/) {
        return "int";
    } elsif ($var =~ /^\d*\.\d+$/) {
        return "float";
    } elsif ($var =~ /^ +$/) {
        return "str";
    } elsif (length($var) == 1) {
        return "char";
    } else {
        return "tuple";
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(" 99 777"),"tuple")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
