class ProximityLock < Formula
  include Language::Python::Virtualenv

  desc "Lock a Mac when its enrolled paired iPhone is away"
  homepage "https://github.com/Alexa-asdf/proximity-lock"
  url "https://github.com/Alexa-asdf/proximity-lock/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "cacfd59194fdbbee0b4fd2aab67502118070ab9cd9c19de5342ef9a06e0960a9"
  license "Apache-2.0"

  depends_on :macos
  depends_on "python@3.14"

  resource "linkify-it-py" do
    url "https://files.pythonhosted.org/packages/eb/3d/e34b19cd144071c583317268c4feb2c59c03ac57eef69753410c7abb11c0/linkify_it_py-2.1.1-py3-none-any.whl"
    sha256 "8539a6b470efce90ba9b69e39b848e5b15b7ad89f7f98ca17d3532c243f987dc"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/b3/81/4da04ced5a082363ecfa159c010d200ecbd959ae410c10c0264a38cac0f5/markdown_it_py-4.2.0-py3-none-any.whl"
    sha256 "9f7ebbcd14fe59494226453aed97c1070d83f8d24b6fc3a3bcf9a38092641c4a"
  end

  resource "mdit-py-plugins" do
    url "https://files.pythonhosted.org/packages/a5/69/6da5581c6a7fede7dc261bf4e67d6adca4196f176b43288b55b3db395b6e/mdit_py_plugins-0.6.1-py3-none-any.whl"
    sha256 "214c82fb2ac524472ab6a5bcab1de80f73b50443e187f401bfd77efbc7c6481d"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/b3/38/89ba8ad64ae25be8de66a6d463314cf1eb366222074cfda9ee839c56a4b4/mdurl-0.1.2-py3-none-any.whl"
    sha256 "84008a41e51615a49fc9966191ff91509e3c40b939176e643fd50a5c2196b8f8"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/28/be/0ff05fcd2938fb58ad9219bd54135968342d214737e012d62d43f06a2dd6/platformdirs-4.11.4-py3-none-any.whl"
    sha256 "e34ff91a24bcddc6d939b878bdf3f5c437c9c46fe9e212b1bf455fdf1ee57586"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/71/46/17f022dd3e953bf20a04a028a21ec746d942f8d2af30fa0f124fa0e6a684/pygments-2.21.0-py3-none-any.whl"
    sha256 "2363c69b61c4a97c838da3b130dcd6468f4848992b21a82f2a63ec34377137d9"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/82/3b/64d4899d73f91ba49a8c18a8ff3f0ea8f1c1d75481760df8c68ef5235bf5/rich-15.0.0-py3-none-any.whl"
    sha256 "33bd4ef74232fb73fe9279a257718407f169c09b78a87ad3d296f548e27de0bb"
  end

  resource "textual" do
    url "https://files.pythonhosted.org/packages/fb/be/35261223d9416a0751cdff1c7b4a6f881387218a12d439fe22fefebc8c04/textual-8.2.8-py3-none-any.whl"
    sha256 "267375fd402dc8d981457212efa71f0e3365fd17bba144ba9bb3ed7563cb374a"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/49/d3/b8441a820a491ddfc024b0b0cf0393375b75ea13866d9c66727e54c2fc80/typing_extensions-4.16.0-py3-none-any.whl"
    sha256 "481caa481374e813c1b176ada14e97f1f67a4539ce9cfeb3f350d78d6370c2e8"
  end

  resource "uc-micro-py" do
    url "https://files.pythonhosted.org/packages/61/73/d21edf5b204d1467e06500080a50f79d49ef2b997c79123a536d4a17d97c/uc_micro_py-2.0.0-py3-none-any.whl"
    sha256 "3603a3859af53e5a39bc7677713c78ea6589ff188d70f4fee165db88e22b242c"
  end

  def install
    python = formula_opt_bin("python@3.14")/"python3.14"
    venv = virtualenv_create(libexec/"proximity-lock/venv", python)
    venv.pip_install resources
    system "make", "install-runtime", "PREFIX=#{prefix}"
  end

  test do
    assert_predicate libexec/"proximity-lock/bin/lockmac-private", :executable?
    assert_match "PASS", shell_output(
      "#{libexec}/proximity-lock/bin/proximity-lock-enrollment --enrollment-self-check",
    )
    assert_match "PASS", shell_output("#{libexec}/proximity-lock/bin/lockmac-private --identity-self-check")
  end
end
