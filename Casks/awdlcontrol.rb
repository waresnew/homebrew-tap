# NOTE: ai generated
cask("awdlcontrol") do
  version("1.0.6")
  sha256("64563ce2c6d0d92c9296ad1d6dcf29fe78f1cb5869323927c62e24485fe25744")

  url("https://github.com/james-howard/AWDLControl/releases/download/v#{version}/AWDLControl.zip")
  name("AWDL Control")
  desc("Menu bar app to control Apple Wireless Direct Link (AWDL)")
  homepage("https://github.com/james-howard/AWDLControl")

  livecheck do
    url(:url)
    strategy(:github_latest)
  end

  depends_on(arch: :arm64)
  depends_on(macos: ">= :ventura")

  app("AWDLControl.app")

  # disable Sparkle's automatic update checks/installs so no update dialog
  # pops up when the app is launched/killed by automation
  postflight do
    system_command(
      "/usr/bin/defaults",
      args: ["write", "com.jh.AWDLControl", "SUEnableAutomaticChecks", "-bool", "false"]
    )
    system_command(
      "/usr/bin/defaults",
      args: ["write", "com.jh.AWDLControl", "SUAutomaticallyUpdate", "-bool", "false"]
    )
  end

  uninstall(quit: "com.jh.AWDLControl")

  zap(
    trash: [
      "~/Library/Caches/com.jh.AWDLControl",
      "~/Library/HTTPStorages/com.jh.AWDLControl",
      "~/Library/Preferences/com.jh.AWDLControl.plist"
    ]
  )

  caveats(
    <<~EOS
      Launch AWDLControl.app and click "Register Helper" to install its helper
      (requires admin authorization).

      Sparkle automatic update checks have been disabled; upgrade via `brew upgrade`.

      personal note: Set the mode to "AWDL off" if you want to automate the app
    EOS
  )
end
