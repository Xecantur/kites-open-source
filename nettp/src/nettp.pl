#!/usr/bin/perl
use strict;
use Net::FTP;
use Term::ReadKey;
use Term::ANSIColor;

my $ftp = Net::FTP->new($ARGV[0],Debug => 0)
or die "Can\'t Connect either because you didn\'t specify a valid address or the host is currently down.\n";
print color 'bold white';
print "Login to $ARGV[0]\n";
print "User: ";
chomp(my $tone = <STDIN>);
print "Pass: ";
ReadMode 2;
chomp(my $ttwo = <STDIN>);
ReadMode 0;
print "\n";
$ftp->login($tone,$ttwo)
or die "Can\'t login\n";
my $input;
my $quit = 0;
while ($quit != 10){
	print color 'bold green';
	print "nettp> "; print color 'bold yellow';
	$input = <STDIN>;
	print color 'reset';
	chomp $input;
	if($input =~ /^ls(\s+(.*))?$/ ){
		my @ls_arr = $ftp->dir($2);
		my $item = 0;
		foreach(@ls_arr){
		print color 'bold cyan';
		print "[".$item++."] $_\n";
		}
	print color 'reset';
	}
	elsif($input =~ /^help$/i){
		print color 'bold white';
		print "nettp help:\n";
		print "cd:  Change Directory\n";
		print "ls:  list directory\n";
		print "get: get remotefile\n";		
		print "put: put file on Server\n";
		print "getr: get remotefile localfile\n";
		print "putr: put localfile  remotefile\n";
		print "help: this help\n";
		print "quit: quit nettp\n";
		print color 'reset';
	}
	elsif($input =~ /^putr(\s+(.*)\s+(.*))$/){
		print "Putting $2 ...\n";
		print "at $3 ...\n";
		$ftp->put($2,$3);
	}
	elsif($input =~ /^exit$/i){
		print "Quitting...\n";
		$quit = 10;
	}	
	elsif($input =~ /^put(\s+(.*))$/ ){
		print "Putting .. $2 on Server $ARGV[0]\n";
		$ftp->put($2);
	}
	elsif($input =~ /^quit$/i){
		print "Quitting...\n";
		$quit = 10;
	}
	elsif($input =~ /^cd (.*)$/){
	 $ftp->cwd($1);
	}
	elsif($input =~ /^getr(\s+(.*)\s+(.*))$/ ) {
	print "Getting $2 ...\n";
	print "Saving as $3 ..\n";
	$ftp->get($2,$3);
	}
	elsif($input =~ /^get(\s+(.*))$/){
		print "Getting $2 ..\n";
		$ftp->get($2);
	}
	else{
	print "Undefined command\n";
	}
}

