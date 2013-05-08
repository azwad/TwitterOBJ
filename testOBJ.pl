#!/usr/bin/perl
use strict;
use warnings;
use TwitterOBJ;
use lib '/home/toshi/perl/lib';
use HashDump;
use feature 'say';
use Pause;
use utf8;

my $tw = TwitterOBJ->new;

my $opt = {
	pit_account => 'toshi.private',
	method => 'get_lists',
	twopt => {
			user_name => '_toshi',
	},
};

my  $res = $tw->get($opt);

HashDump->load($res);
pause;


$opt->{method} = 'favorites';

$res = $tw->get($opt);

HashDump->load($res);
pause;

$opt->{method} = 'update';
$opt->{twopt} = {
	status => 'HelloWorld by TwitterOBJ.pm'
};

eval {$res =  $tw->get($opt)};

HashDump->load($res);
pause;


$opt->{method} = 'home_timeline';
$opt->{twopt} = {};

$res =  $tw->get($opt);

HashDump->load($res);
pause;


$opt->{method} = 'mentions';
$opt->{twopt} = {};

$res =  $tw->get($opt);

HashDump->load($res);
pause;


$opt->{method} = 'search';
$opt->{twopt} = {
	q => '糸魚川',
};

$res =  $tw->get($opt);

HashDump->load($res);
pause;


