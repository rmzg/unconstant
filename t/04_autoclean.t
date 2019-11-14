use Test::More tests => 2;

SKIP: {
	eval { require namespace::autoclean };
	skip "namespace_autoclean not installed", 2 if $@;

	package Foo {
		use unconstant;
		use constant FOO => 42;
	}

	package Bar {
		require namespace::autoclean;
		namespace::autoclean->import(); # I hope this is the same as 'use namespace::autoclean'
		                                # But we can't do that because of compile time errors..
		use unconstant;
		use constant FOO => 42;
	}

	is ( Foo::FOO, 42, "Without namespace::autoclean" );
	is ( Bar::FOO, 42, "With namespace::autoclean" );
}
