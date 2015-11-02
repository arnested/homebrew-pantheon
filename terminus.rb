require File.expand_path("../../../homebrew/homebrew-php/Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  desc "Terminus: The Pantheon CLI"
  homepage "https://github.com/pantheon-systems/cli"
  url "https://github.com/pantheon-systems/cli/archive/0.9.2.tar.gz"
  sha256 "a9c0e46052d7b753603421c53f40c746372fb8efbd2f3d587eb3a0288753f8f6"
  head "https://github.com/pantheon-systems/cli.git"

  depends_on PhpMetaRequirement
  depends_on "composer" => :build

  def install
    system "composer", "install"
    libexec.install Dir["*"]

    (bin+"terminus").write <<-EOS.undent
      #!/bin/sh

      exec "#{libexec}/bin/terminus" "$@"
    EOS

    bash_completion.install libexec/"utils/terminus-completion.bash"
  end

  test do
    system "terminus cli info | grep -q 'Terminus root dir:\t*#{libexec}'"
  end
end
