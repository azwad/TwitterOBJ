#!/usr/bin/perl
use strict;
use warnings;
use TwitterOBJ;
use lib qw(/home/toshi/perl/lib);
use HashDump;
use feature 'say';
use Pause;
use utf8;

my $tw = TwitterOBJ->new;

my $opt = {
	pit_account => 'toshi.private',
	method => 'search',
	twopt =>  {
		q => 'API 1.1',
	}
};

#my  $res = $tw->get($opt);

#$opt->{method} = 'search';
#$opt->{twopt} = '糸魚川';


my $res =  $tw->get($opt);

HashDump->load($res);
pause;


