#!/usr/bin/env bash

export FERMENTER_REPO_URL="https://github.com/vifo/perlbrew-fermenter"
export FERMENTER_PERL_VERSION=${FERMENTER_PERL_VERSION:-5.18.2}
export FERMENTER_ROOT=${FERMENTER_ROOT:-/usr/local/perl}
export FERMENTER_NO_MAN_PAGES=${FERMENTER_NO_MAN_PAGES:-1}
export FERMENTER_NO_TESTS=${FERMENTER_NO_TESTS:-1}

export PERLBREW_ROOT=${PERLBREW_ROOT:-${FERMENTER_ROOT}}
export PERLBREW_HOME=${PERLBREW_HOME:-${PERLBREW_ROOT}}

MAX_JOBS=$(( $(grep -i processor "/proc/cpuinfo" |wc -l) - 1 ))
if [[ $MAX_JOBS -le 0 ]]; then
    MAX_JOBS=1
fi

# Adjust runtime flags for perlbrew and cpanm in order to suppress man page
# generation and disable tests.
PERLBREW_CONFIGURE_FLAGS=""
PERLBREW_INSTALL_FLAGS=""
PERL_CPANM_OPT=""

if [[ $FERMENTER_NO_MAN_PAGES == 1 ]]; then
    PERLBREW_CONFIGURE_FLAGS+=" -Uman1dir -Uman3dir -Usiteman1dir -Usiteman3dir -Uvendorman1dir -Uvendorman3dir"
    PERLBREW_INSTALL_FLAGS+=" --noman"
    PERL_CPANM_OPT+=" --no-man-pages"
fi
if [[ $FERMENTER_NO_TESTS == 1 ]]; then
    PERLBREW_INSTALL_FLAGS+=" --notest"
    PERL_CPANM_OPT+=" --notest"
fi

PERLBREW_CONFIGURE_FLAGS+=" -Dcc=gcc -Dinstallusrbinperl=n -Dpager=/usr/bin/sensible-pager -des"
PERLBREW_INSTALL_FLAGS+=" -j${MAX_JOBS}"

export PERLBREW_CONFIGURE_FLAGS PERLBREW_INSTALL_FLAGS PERL_CPANM_OPT

# Perl modules to install by default
PERL_MODULES_NOTEST=$(cat <<EO_PERL_MODULES_NOTEST
JSON
JSON::PP
YAML
YAML::XS
ExtUtils::MakeMaker
Module::Build
EO_PERL_MODULES_NOTEST
)

PERL_MODULES=$(cat <<EO_PERL_MODULES
autodie
base
parent
version
MIME::Base64
Digest::MD5
Digest::SHA1
DBI
DBIx::Class
LWP
Moose
Params::Validate
Storable
Time::HiRes
Term::ReadLine
WWW::Mechanize
EO_PERL_MODULES
)

# Compiler settings
export CC=${CC:-gcc}
export CXX=${CXX:-g++}
export CFLAGS=${CFLAGS:--march=native -O2 -Wall -pipe}
export CXXFLAGS=${CXXFLAGS:-$CFLAGS}

if [ -f "${PERLBREW_ROOT}/etc/bashrc" ]; then
    source "${PERLBREW_ROOT}/etc/bashrc"
fi

# Install /etc/profile.d/perlbrew.sh containing global perlbrew settings.
function install_etc_profile_d_perlbrew_sh() {
    cat >/etc/profile.d/perlbrew.sh.dist <<EOF
#!/bin/sh

export PERL_CPANM_OPT="${PERL_CPANM_OPT}"
export PERLBREW_ROOT="${PERLBREW_ROOT}"
export PERLBREW_HOME="\${PERLBREW_ROOT}"
export PERLBREW_CONFIGURE_FLAGS="${PERLBREW_CONFIGURE_FLAGS}"

source "\${PERLBREW_ROOT}/etc/bashrc"
EOF
    chown root.root /etc/profile.d/perlbrew.sh.dist
    chmod 644 /etc/profile.d/perlbrew.sh.dist

    if [ -f "/etc/profile.d/perlbrew.sh" ]; then
        cat /etc/profile.d/perlbrew.sh.dist >/etc/profile.d/perlbrew.sh
    else
        install -m755 -oroot -groot /etc/profile.d/perlbrew.sh.dist /etc/profile.d/perlbrew.sh
    fi
}

# Install perlbrew
function install_perlbrew() {
    curl -L http://install.perlbrew.pl | bash
    install_etc_profile_d_perlbrew_sh
    source "${PERLBREW_ROOT}/etc/bashrc"
}

function install_perl() {
    perlbrew install perl-${FERMENTER_PERL_VERSION} ${PERLBREW_INSTALL_FLAGS} ${PERLBREW_CONFIGURE_FLAGS}
}

function install_cpan_config() {
    # TODO: Adjust variables in Config.pm according to current Perl version.
    curl https://raw.github.com/vifo/perlbrew-fermenter/master/assets/Config.pm \
        >/usr/local/perl/perls/perl-${FERMENTER_PERL_VERSION}/lib/${FERMENTER_PERL_VERSION}/CPAN/Config.pm
}

function upgrade_perl_modules() {
    perlbrew exec --with perl-${FERMENTER_PERL_VERSION} cpanm ${PERL_CPANM_OPT} --notest ${PERL_MODULES_NOTEST}
    perlbrew exec --with perl-${FERMENTER_PERL_VERSION} cpanm ${PERL_CPANM_OPT} ${PERL_MODULES}
}

install_perlbrew
install_perl
install_cpan_config
upgrade_perl_modules
