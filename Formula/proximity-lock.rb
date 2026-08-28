class ProximityLock < Formula
  include Language::Python::Virtualenv

  desc "Lock a Mac when its enrolled paired iPhone is away"
  homepage "https://github.com/Alexa-asdf/proximity-lock"
  license "Apache-2.0"
  # RELEASE REQUIRED: retain this immutable tag URL and add its verified SHA-256.
  # url "https://github.com/Alexa-asdf/proximity-lock/archive/refs/tags/v0.1.0.tar.gz"
  # sha256 "RELEASE_ARCHIVE_SHA256"
  version "0.1.0"

  depends_on :macos
  depends_on "python@3.14"

  # RELEASE REQUIRED: add one SHA-256-pinned resource stanza for every entry in
  # requirements.txt, including transitive dependencies, from the released source tree.
  def install
    python = Formula["python@3.14"].opt_bin/"python3.14"
    venv = virtualenv_create(libexec/"proximity-lock/venv", python)
    venv.pip_install resources
    system "make", "install-runtime", "PREFIX=#{prefix}"
  end

  test do
    assert_predicate libexec/"proximity-lock/bin/lockmac-private", :executable?
    assert_match "PASS", shell_output("#{libexec}/proximity-lock/bin/proximity-lock-enrollment --enrollment-self-check")
    assert_match "PASS", shell_output("#{libexec}/proximity-lock/bin/lockmac-private --identity-self-check")
  end
end
