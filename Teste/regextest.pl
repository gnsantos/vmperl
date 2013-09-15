#!/usr/bin/perl
use strict;

while(<>){
    chomp($_);
    if(/^#.*[\n\f]*/){
	print "Linha de comentario.\n"
    }
    else{
	if(/([a-zA-Z]*:\s*)[\n\f#]+/){
	    print "Linha so com TAG."."Tag = ".$1."\n";
	}
	else{
	    if(/^\n/){
		print "Blank line.\n";
	    }
	    else{
		if(/([a-zA-Z]*:\s*)?(\b[a-zA-Z]{2,4}\b[^:]?)(\w*)\s*[\n\f#]*/){
		    print "Argumentos: ";
		    print $1." ".$2." ".$3."\n";
		}
	    }
	}
    }
}
