require File.expand_path("../../../homebrew/homebrew-php/Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  desc "Terminus: The Pantheon CLI"
  homepage "https://github.com/pantheon-systems/cli"
  url "https://github.com/pantheon-systems/cli/archive/0.5.6.tar.gz"
  sha256 "4e4c42442c51adf60635df9c56f2f39a4b1d628abb9c2e936fa83082c34c3390"
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

    bash_completion.install libexec/"utils/wp-completion.bash" => "pantheon.wp"
  end

  test do
    system "terminus cli info | grep -q 'Terminus root dir:\t*#{libexec}'"
  end
end
