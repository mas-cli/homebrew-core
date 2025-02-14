class Libshumate < Formula
  desc "Shumate is a GTK toolkit providing widgets for embedded maps"
  homepage "https://gitlab.gnome.org/GNOME/libshumate"
  url "https://download.gnome.org/sources/libshumate/1.3/libshumate-1.3.1.tar.xz"
  sha256 "6efe9352d91744822d41ead4714a2ab4b378481a86a2204b7bec4082dffc1b8b"
  license "LGPL-2.1-or-later"

  # libshumate doesn't use GNOME's "even-numbered minor is stable" version
  # scheme. This regex is the same as the one generated by the `Gnome` strategy
  # but it's necessary to avoid the related version scheme logic.
  livecheck do
    url :stable
    regex(/libshumate[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_sequoia: "8d6650eb26fef5c8fdc34133cc672cf4d112e39589924291350c5f6344a6d349"
    sha256 cellar: :any, arm64_sonoma:  "c22e2372194637890cb28c858eaea452cbe956092b2faaee8c916c410f726347"
    sha256 cellar: :any, arm64_ventura: "abbf4c76fd535b4a5cf262f125555796d542dcdd1017c852e0f01b565a1f5554"
    sha256 cellar: :any, sonoma:        "1c7781442dd71a4cdd82d55d5c2762449b8bfea651d5e522ab8cdcbed836365d"
    sha256 cellar: :any, ventura:       "9c59b7858b81fe0c9052cc601a79927c4dc111e0fc3fbee5110dc7a435428a01"
    sha256               x86_64_linux:  "2574f1139c9c8405281d70dfc1734c0bd63d54bde7877c94c76c313f0fadd483"
  end

  depends_on "gettext" => :build
  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "vala" => :build

  depends_on "cairo"
  depends_on "gdk-pixbuf"
  depends_on "glib"
  depends_on "graphene"
  depends_on "gtk4"
  depends_on "json-glib"
  depends_on "libsoup"
  depends_on "pango"
  depends_on "protobuf-c"
  depends_on "sqlite"

  uses_from_macos "gperf" => :build

  on_macos do
    depends_on "gettext"
  end

  def install
    system "meson", "setup", "build", "-Dgtk_doc=false", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <shumate/shumate.h>

      int main(int argc, char *argv[]) {
        char version[32];
        snprintf(version, 32, "%d.%d.%d", SHUMATE_MAJOR_VERSION, SHUMATE_MINOR_VERSION, SHUMATE_MICRO_VERSION);
        return 0;
      }
    C

    # TODO: remove this after rewriting icu-uc in `libpsl`'s pkg-config file
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["icu4c"].opt_lib/"pkgconfig" if OS.mac?

    flags = shell_output("#{Formula["pkgconf"].opt_bin}/pkgconf --cflags --libs shumate-1.0").strip.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"

    # include a version check for the pkg-config files
    assert_match version.to_s, (lib/"pkgconfig/shumate-1.0.pc").read
  end
end
