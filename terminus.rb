require File.expand_path("../../../homebrew/homebrew-php/Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  desc "Terminus: The Pantheon CLI"
  homepage "https://github.com/pantheon-systems/cli"
  url "https://github.com/pantheon-systems/cli/archive/0.10.2.tar.gz"
  sha256 "9daf9656390217c9f1dea111d9fbb88068b3eec626752955dfd477ffba8d8108"
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
    system "terminus cli info | grep -q 'Terminus root dir: *\\| *#{libexec}'"
  end
end
