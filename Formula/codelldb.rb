# building codelldb fully from source + with lldb subset was too hard
class Codelldb < Formula
  desc "A VSCode debugger extension for native code, powered by LLDB."
  homepage "https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb"
  version "1.12.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/vadimcn/codelldb/releases/download/v#{version}/codelldb-darwin-arm64.vsix"
      sha256 "c836b81c6f2da467b5920a376a7bfc849dc4b4d81b19779dedf1c685cb4aa1a0"
    else
      url "https://github.com/vadimcn/codelldb/releases/download/v#{version}/codelldb-darwin-x64.vsix"
      sha256 "8270a342929bdc0deb6d7d3931c08d5ba6018265f840dd0508c4247fb8d32e8d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/vadimcn/codelldb/releases/download/v#{version}/codelldb-linux-arm64.vsix"
      sha256 "f7c83ad67cc860fe6d753e8123b57a4db89c1fb00aef4b85a2f858334cdbaeb0"
    else
      url "https://github.com/vadimcn/codelldb/releases/download/v#{version}/codelldb-linux-x64.vsix"
      sha256 "b85b45a8570051d535b0927c6c9da11c39f3a056c73559064647faf7f37f637d"
    end
  end

  def install
    system("unzip", "-q", cached_download, "-d", buildpath)
    libexec.install("extension/adapter")
    libexec.install("extension/lldb")
    libexec.install("extension/package.json")
    bin.write_exec_script(libexec / "adapter/codelldb")
  end

  test do
    system "#{bin}/codelldb", "--help"
  end
end
