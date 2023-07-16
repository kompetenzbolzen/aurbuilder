#!/usr/bin/env python3
# Create a list of package names required to build supplied AUR package.
# packages present in the official repos will be ignored.

# relevant docs:
# AUR API:
# https://wiki.archlinux.org/title/Aurweb_RPC_interface
# Package API:
# https://wiki.archlinux.org/title/Official_repositories_web_interface

import os
import sys
import requests
import json

#from packaging import version
#version.parse

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


# TODO we should actually use version limits instead
def sanitize_name(_name):
    _name = _name.replace('<','=')
    _name = _name.replace('>','=')

    return _name.split('=')[0]


# TODO: Don't just take the first one. prioritize maybe Votes, version, git, bin, ...
def aur_search_package(_name):
    _name = sanitize_name(_name)

    data = requests.get(f'https://aur.archlinux.org/rpc/?v=5&type=search&by=name&arg={_name}').json()

    for r in data['results']:
        p = aur_get_package(r['Name'])
        if p is None:
            continue

        if 'Provides' in p:
            for prov in p['Provides']:
                if sanitize_name(prov) == _name:
                    return p

    return None


def aur_get_package(_name):
    _name = sanitize_name(_name)

    data = requests.get(f'https://aur.archlinux.org/rpc/?v=5&type=info&arg={_name}').json()

    if len(data['results']) != 1:
        return aur_search_package(_name)

    return data['results'][0]


def repo_search_package(_name):
    _name = sanitize_name(_name)

    data = requests.get(f'https://archlinux.org/packages/search/json/?q={_name}').json()
    for r in data['results']:
        p = repo_get_package(r['pkgname'], False)
        if p is None:
            continue

        if 'provides' in p:
            for prov in p['provides']:
                if sanitize_name(prov) == _name:
                    return p

    return None


def repo_get_package(_name, _search=True):
    _name = sanitize_name(_name)

    data = requests.get(f'https://archlinux.org/packages/search/json/?name={_name}').json()

    if len(data['results']) != 1:
        if _search:
            return repo_search_package(_name)
        else:
            return None

    return data['results'][0]


def build_aur_dependencies(_pkgname):
    _pkgname = sanitize_name(_pkgname)

    ret = []

    maybe_deps = aur_get_package(_pkgname)
    if maybe_deps is None:
        eprint(f'WARNING: {_pkgname} Was not found in AUR!')
        return []
    elif 'Depends' not in maybe_deps:
        return []

    deps = maybe_deps['Depends']

    for dep in deps:
        # if package exists in official repo
        if repo_get_package(dep) is not None:
            continue

        # detect depency cycles
        if dep in ret:
            continue

        ret.append(dep)
        ret.insert(0,dep)
        ret = build_aur_dependencies(dep) + ret

    return ret

if len(sys.argv) <= 1:
    eprint('CRITICAL: No package name provided.')
    exit(1)

PKG=sys.argv[1]

# name: version
TO_BUILD={}

maybe_base_pkg_info = aur_get_package(PKG)
if maybe_base_pkg_info is None:
    eprint(f'CRITICAL: Package {PKG} not found in AUR')
    exit(1)
base_pkg_info = maybe_base_pkg_info

aur_deps = build_aur_dependencies(PKG)

# We rely on the rigth order here.
# The dependency must be before the package that depends on it,
# otherwise makepkg will fail
for dep in aur_deps:
    pkg = aur_get_package(dep)

    if pkg is None:
        eprint(f'WARNING: Dependency {dep} Unmet!')
        continue

    TO_BUILD[pkg['Name']] = {
            'version':pkg['Version'],
            'base':pkg['PackageBase']
        }

TO_BUILD[base_pkg_info['Name']] = {
        'version':base_pkg_info['Version'],
        'base':base_pkg_info['PackageBase']
        }

for e in TO_BUILD:
    print(f'{e}\t{TO_BUILD[e]["base"]}\t{TO_BUILD[e]["version"]}')
