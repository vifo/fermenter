# fermenter

Modernize your Perl! System-wide installation of [Perl 5.18.2](http://www.cpan.org/src/README.html), [perlbrew](http://perlbrew.pl/) and recommended modules to `/usr/local/perl` on [various Linux distributions]() in one shot. Root required. Handle with care.

```bash
# install Perl 5.18.2 and recommended modules via perlbrew to /usr/local/perl.
curl https://raw.github.com/vifo/perlbrew-fermenter/master/fermenter.sh | bash
```

## Motivation

*perlbrew* is great for setting up and managing multiple, isolated Perl.
Still, even with *perlbrew*, you still have to install build dependencies,
adjust compiler flags, update Perl modules after installation. cleanup and so
on.

This is, where *fermenter* kicks in. It simplifies the installation of Perl
via *perlbrew* by providing sensible defaults, adjusting compiler flags and
handling build dependencies for the Linux distribution of your choice.

### fermenter?

[perlbrew](http://perlbrew.pl/) => [brew](https://duckduckgo.com/?q=brew+verb) => [brewing](http://en.wikipedia.org/wiki/Brewing) => [fermentation](http://en.wikipedia.org/wiki/Fermentation) => [fermenter](http://en.wiktionary.org/wiki/fermenter) for the curious.

<a name="#supported-tested-distributions" />

## Supported/tested distributions

* [Linux Mint 15 (Olivia)](http://www.linuxmint.com/release.php?id=20)
* [Ubuntu 10.04.4 LTS (Lucid Lynx)](http://releases.ubuntu.com/lucid/)
* and [more](https://github.com/vifo/fermenter/blob/master/DISTRIBUTIONS.md)

Distribution not listed? [Review open issues/open new one](https://github.com/vifo/fermenter/issues)

## Documentation

Detailed docs currently only available as source code comments (if any).

### fermenter is great, but I want to...

* change the installation directory

```bash
$ FERMENTER_ROOT=/usr/local/fermenter curl https://raw.github.com/vifo/perlbrew-fermenter/master/fermenter.sh | bash
```

## Links

* [perlbrew Homepage](http://perlbrew.pl/)
* [App::perlbrew on metacpan](https://metacpan.org/release/App-perlbrew)

## Copyright and license

Copyright 2014, Victor Foitzik. *perlbrew-fermenter* is released under the MIT license. Please refer to [the license file](https://raw.github.com/vifo/perlbrew-fermenter/master/fermenter.sh) for details.
