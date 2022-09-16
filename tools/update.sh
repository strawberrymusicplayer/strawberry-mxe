#!/bin/bash
#
#  STRAWBERRY MXE GITHUB ACTION UPDATE SCRIPT
#  Copyright (C) 2022 Jonas Kvinge
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

repo="strawberrymusicplayer/strawberry-mxe"

function timestamp() { date '+%Y-%m-%d %H:%M:%S'; }
function error() { echo "[$(timestamp)] ERROR: $*" >&2; }

function update_package() {

  local package_file
  local package_name
  local package_version
  local package_branch

  package_file="${1}"

  package_name=$(grep '^PKG\s*:= ' ${package_file} | sed -e 's/^PKG\s*:= \(.*\)/\1/' || exit 1)
  if [ "${package_name}" = "" ]; then
    echo "Could not get package name for ${package_file}"
    return
  fi

  package_version=$(grep '$(PKG)_VERSION\s\+:=\s\+' ${package_file} | sed -e 's/^\$(PKG)_VERSION\s\+:=\s\+\(.*\)/\1/' || exit 1)
  if [ "${package_name}" = "" ]; then
    echo "Could not get package name for ${package_file}"
    return
  fi

  # Make sure we have a checksum, otherwise the update failed.
  grep '^\$(PKG)_CHECKSUM\s\+:=\s\+$' ${package_file} >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Skipping ${package_name} (${package_file}), invalid checksum."
    git checkout "${package_file}"
    return
  fi

  package_branch="${package_name}_$(echo ${package_version} | sed 's/\./_/g')"
  git branch | grep "${package_branch}" >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Skipping ${package_name} (${package_file}), branch for version ${package_version} already exists."
    git checkout "${package_file}"
    return
  fi

  echo "${package_name}: ${package_version}"
  git checkout -b "${package_branch}" || exit 1
  git add "${package_file}" || exit 1
  git commit -m "Update ${package_name}" "${package_file}" || exit 1
  git push origin "${package_branch}" || exit 1
  gh pr create --repo "${repo}" --head "${package_branch}" --base "master" --title "Update ${package_name} to ${package_version}" --body "Update ${package_name} to ${package_version}" || exit 1
  if ! [ "$(git branch | head -1 | cut -d ' ' -f2)" = "master" ]; then
    git checkout master >/dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "Could not checkout master branch."
      exit 1
    fi
  fi

}

cmds="dirname cat cut sort tr grep sed wget curl git gh"
cmds_missing=
for cmd in ${cmds}; do
  which "${cmd}" >/dev/null 2>&1
  if [ $? -eq 0 ] ; then
    continue
  fi
  if [ "${cmds_missing}" = "" ]; then
    cmds_missing="${cmd}"
  else
    cmds_missing="${cmds_missing}, ${cmd}"
  fi
done

if ! [ "${cmds_missing}" = "" ]; then
  error "Missing ${cmds_missing} commands."
  exit 1
fi

dir="$(dirname "$0")"

if [ "${dir}" = "" ]; then
  echo "Could not get current directory."
  exit 1
fi

if ! [ -d "${dir}" ]; then
  echo "Missing ${dir}"
  exit 1
fi

if ! [ -d "${dir}/../.git" ]; then
  echo "Missing ${dir}/../.git"
  exit 1
fi

if ! [ -f "${dir}/../Makefile" ]; then
  echo "Missing ${dir}/../Makefile"
  exit 1
fi

repodir="$(dirname "${dir}")"

if ! [ -d "${repodir}" ]; then
  echo "Missing ${repodir}."
  exit 1
fi

cd "${repodir}"
if [ $? -ne 0 ]; then
  echo "Could not change directory to ${repodir}."
  exit 1
fi

git status >/dev/null
if [ $? -ne 0 ]; then
  error "Git status failed."
  exit 1
fi

gh auth status >/dev/null
if [ $? -ne 0 ]; then
  error "Missing GitHub login."
  exit 1
fi

git fetch >/dev/null 2>&1 || exit 1
if [ $? -ne 0 ]; then
  echo "Could not fetch"
  exit 1
fi

git checkout . >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Could not checkout ."
  exit 1
fi

if ! [ "$(git branch | head -1 | cut -d ' ' -f2)" = "master" ]; then
  git checkout master >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "Could not checkout master branch."
    exit 1
  fi
fi

git pull origin master --rebase >/dev/null
if [ $? -ne 0 ]; then
  echo "Could not pull with rebase ."
  exit 1
fi

make update
#if [ $? -ne 0 ]; then
#  echo "make update failed :("
#  exit 1
#fi

package_files=$(git ls-files src/*.mk --modified || exit 1)
if [ "${package_files}" = "" ]; then
  exit 0
fi

for package_file in ${package_files}; do
  update_package "${package_file}"
  if ! [ "$(git branch | head -1 | cut -d ' ' -f2)" = "master" ]; then
    git checkout master >/dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "Could not checkout master branch."
      exit 1
    fi
  fi
done

git checkout . >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Could not checkout ."
  exit 1
fi

git pull origin master --rebase >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Could not pull with rebase ."
  exit 1
fi
