#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "Installing golang tools..."
go_packages=(
    github.com/acroca/go-symbols  # Extract Go symbols as JSON
    github.com/cweill/gotests/...  # Generate tests
    github.com/derekparker/delve/cmd/dlv  # Debugger
    github.com/fatih/gomodifytags  # Modify/update field tags in structs
    github.com/golang/lint/golint  # Go linter
    github.com/josharian/impl  # Generate method stubs for an interface
    github.com/nsf/gocode  # Autocomplete
    github.com/ramya-rao-a/go-outline  # Extract Go declarations as JSON
    github.com/rogpeppe/godef  # Print where symbols are defined
    github.com/sqs/goreturns  # Add zero values to return statements to save time
    github.com/tpng/gopkgs  # Faster `go list all`
    golang.org/x/tools/cmd/godoc  # Go documentation tool
    golang.org/x/tools/cmd/gorename  # Rename identifiers
    golang.org/x/tools/cmd/guru  # Answers questions about Go code
    github.com/senorprogrammer/wtf # Terminal dashboard
)

for package in "${go_packages[@]}"; do
    go get -u "$package" &> /dev/null && \
        message "    %s" "Installed $package" || \
        warn "    %s" "package $package failed to install"
done

message "  %s" "Installing wtf..."
(cd "$GOPATH/src/github.com/senorprogrammer/wtf" && go install -ldflags="-s -w")
message "  %s" "Done installing wtf."

message "Golang done."
