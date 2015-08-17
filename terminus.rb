require File.expand_path("../../../homebrew/homebrew-php/Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  desc "Terminus: The Pantheon CLI"
  homepage "https://github.com/pantheon-systems/cli"
  url "https://github.com/pantheon-systems/cli/archive/0.6.1.tar.gz"
  sha256 "66ba41fff1b274a15da3be53b7dd9cfbd32d177519f604b8daa737a713566f4a"
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
