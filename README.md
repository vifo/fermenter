# fermenter

Modernize your Perl! System-wide installation of [Perl 5.18.2][link_perl_5_18_2], [perlbrew][link_perlbrew] and recommended modules to `/usr/local/perl` on [various Linux distributions][link_distributions_md] in one shot. Root required. Handle with care.

```bash
# install Perl 5.18.2 and recommended modules via perlbrew to /usr/local/perl.
curl https://raw.github.com/vifo/fermenter/master/fermenter.sh | bash
```

## Motivation

*perlbrew* is great for setting up and managing multiple, isolated Perl installations. Yet, even with *perlbrew*, you still have to care yourself for possible build dependencies, adjust compiler flags, update Perl modules after installation. cleanup and so on.

This is, where *fermenter* kicks in. It simplifies the installation of Perl via *perlbrew* by providing sensible defaults, adjusting compiler flags, handling build dependencies and finally building and installing Perl including recommended modules.

### fermenter?

[perlbrew](http://perlbrew.pl/) => [brew](https://duckduckgo.com/?q=brew+verb) => [brewing](http://en.wikipedia.org/wiki/Brewing) => [fermentation](http://en.wikipedia.org/wiki/Fermentation) => [fermenter](http://en.wiktionary.org/wiki/fermenter) for the curious.

<a name="#supported-tested-distributions" />

## Supported/tested distributions

* [Linux Mint 15 (Olivia)][link_distribution_linux_mint_15_olivia]
* [Ubuntu 10.04.4 LTS (Lucid Lynx)][link_distribution_ubuntu_10_04_lts_lucid_lynx]
* and [more][link_distributions_md].

Distribution not listed? [Review open issues/open new one][link_issues]

## Documentation

Detailed docs currently only available as source code comments (if any).

### fermenter is great, but I want to...

* change the installation directory

    ```bash
    $ FERMENTER_ROOT=/usr/local/fermenter \
        curl https://raw.github.com/vifo/fermenter/master/fermenter.sh | bash
    ```

## Links

* [perlbrew Homepage][link_perlbrew]
* [App::perlbrew on metacpan][link_perlbrew_metacpan]

## Copyright and license

Copyright 2014, Victor Foitzik. *perlbrew-fermenter* is released under the MIT license. Please refer to [the license file][link_license_md] for details.

[link_distributions_md]: DISTRIBUTIONS.md
[link_license_md]: LICENSE.md
[link_perl_5_18_2]: http://www.cpan.org/src/README.html
[link_perlbrew]: http://perlbrew.pl/
[link_perlbrew_metacpan]: https://metacpan.org/release/App-perlbrew
[link_issues]: https://github.com/vifo/fermenter/issues
[link_distribution_linux_mint_15_olivia]: http://www.linuxmint.com/release.php?id=20
[link_distribution_ubuntu_10_04_lts_lucid_lynx]: http://releases.ubuntu.com/lucid
