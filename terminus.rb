require File.expand_path("../../../homebrew/homebrew-php/Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  desc "Terminus: The Pantheon CLI"
  homepage "https://github.com/pantheon-systems/cli"
  url "https://github.com/pantheon-systems/cli/archive/0.7.0.tar.gz"
  sha256 "3ff4d46a7747046c0574724daffdeb22c764d6cd522537a040b6aa2eddbbabc9"
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
