#!/usr/bin/perl
package kbot;
use base qw(Bot::BasicBot);
use YAML;

my $bot = kbot->new(
﻿  ﻿  server => 'irc.saurik.com',
﻿  ﻿  channels => ['#spam','#kbot'],
﻿  ﻿  nick => 'kbot');
our $config = YAML::LoadFile('kelbot.yml');

sub reloadop{
﻿  my $temp = YAML::LoadFile('kelbot.yml');
﻿  $config = $temp;
}#end of reloadop sub declaration

sub said{
﻿  my($self,$message) =@_;
﻿  if($message->{body} =~ '!reloadcfg'){
﻿  ﻿  reloadop();
﻿  }#end of reload op
﻿  if($message->{body} =~ '!oplist'){
﻿  ﻿   our @oparray;
﻿  ﻿   our $size;
﻿  ﻿  foreach(@{$config-> {OP}}){
﻿  ﻿  push(@oparray,$_);
﻿  ﻿  $size = @oparray;
﻿  ﻿  }
﻿  ﻿  $bot->say(channel => $message->{channel},
﻿  ﻿  ﻿    body => 'The Operators are:'."\n");
﻿  ﻿  for (;$x < $size;++$x){
﻿  ﻿  $bot->say(channel => $message->{channel},
﻿  ﻿  ﻿    body => $oparray[$x]);
﻿  ﻿  }#end of for loop say op names
﻿  }#end of !oplist
﻿  if($message->{body} =~ '!addop'){
﻿  ﻿  open(FILE,'>>','kelbot.yml');
﻿  ﻿  if(grep { $_ eq $message->{who} } @{ $config->{OP}}){
﻿  ﻿  ﻿  my $string = $message->{body};
﻿  ﻿  ﻿  $string =~ s/!addop//;
﻿  ﻿  ﻿  print FILE '  -'.$string."\n";
﻿  ﻿  ﻿  close(FILE);
﻿  ﻿  }#end of grep
﻿  }#end of !addop
﻿  if ($message->{body} =~ '!opme'){
﻿  ﻿  if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
﻿  ﻿  ﻿  $bot->mode("$message->{channel} +o $message->{who}");
﻿  ﻿  }#end of grep
﻿  ﻿  else{
﻿  ﻿  ﻿  $bot->say(channel => $message->{channel},
﻿  ﻿  ﻿  ﻿    body => 'You aren\'t in the Operators list.',
﻿  ﻿  ﻿  ﻿    address => $message->{who}); #made it here /tmp
﻿  ﻿  }
﻿  }#end of if !opme
﻿  if($message->{body} =~ '!dopme'){
﻿  ﻿  if(grep { $_ eq $message->{who} } @{ $config->{OP}}){
﻿  ﻿  $bot->mode("$message->{channel} -o $message->{who}");
﻿  ﻿  }
﻿  ﻿  else{
﻿  ﻿  ﻿  $bot->say(channel => $message->{channel},
﻿  ﻿  ﻿  ﻿    body => 'You aren\'t an Operator.',
﻿  ﻿  ﻿  ﻿    address => $message->{who});
﻿  ﻿  }#end of else
﻿  }#end of if !dopme
﻿  if($message->{body} =~ '!gtfo'){
﻿  ﻿  if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
﻿  ﻿  ﻿  $bot->shutdown($bot->quit_message());
﻿  ﻿  }
﻿  ﻿  else{
﻿  ﻿  ﻿  $bot->say(channel => $message->{channel},
﻿  ﻿  ﻿  ﻿    body => 'You aren\'t an Operator.',
﻿  ﻿  ﻿  ﻿    address => $message->{who});
﻿  ﻿  }
﻿  }#end of if !gtfo
﻿  if($message->{body} =~ '!giveop'){
﻿  ﻿  if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
﻿  ﻿  ﻿  my $string;
﻿  ﻿  ﻿  $string = $message->{body};
﻿  ﻿  ﻿  $string =~ s/!giveop //;
﻿  ﻿  ﻿  $bot->mode($message->{channel}.' +o '.$string);
﻿  ﻿  }
﻿  }
﻿  if($message->{body} =~ '!takeop'){
﻿  ﻿  if(grep { $_ eq $message->{who} } @{ $config->{OP}}){
﻿  ﻿  ﻿  my $string;
﻿  ﻿  ﻿  $string = $message->{body};
                        $string =~ s/!takeop //;
                        $bot->mode($message->{channel}.' -o '.$string);
﻿  ﻿  }
﻿  }
﻿  if($message->{body} =~ '!hop'){
﻿  ﻿  if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
﻿  ﻿  ﻿  my $string;
﻿  ﻿  ﻿  $string = $message->{body};
﻿  ﻿  ﻿  $string =~ s/!hop//;
﻿  ﻿  ﻿  $bot->mode($message->{channel}.' +h '.$string);
﻿  ﻿  }
﻿  }
﻿  if($message->{body} =~ '!dhop'){
﻿  ﻿  if(grep { $_ eq $message->{who} } @{ $config->{OP} }){
﻿  ﻿  ﻿  my $string;
﻿  ﻿  ﻿  $string = $message->{body};
﻿  ﻿  ﻿  $string =~ s/!dhop//;
﻿  ﻿  ﻿  $bot->mode($message->{channel}.' -h '.$string);
﻿  ﻿  }
﻿  }

} #end of said
sub chanjoin {
﻿  my($self,$message) = @_;
﻿  my $s = @_;
﻿  my $x = 0;
﻿  for(;$x<$s;++$x){
﻿  print  "$x".@_[$x];
﻿  }
﻿  return 'Kbot Online!, ready to do thy bidding my master!';
}
sub help{ return '!addop,!opme,!dopme,!reloadcfg,!giveop,!takeop,!oplist,!gtfo';};
$bot->run();
