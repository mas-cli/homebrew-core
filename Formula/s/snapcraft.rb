class Snapcraft < Formula
  include Language::Python::Virtualenv

  desc "Package any app for every Linux desktop, server, cloud or device"
  homepage "https://snapcraft.io/"
  url "https://github.com/canonical/snapcraft/archive/refs/tags/8.5.1.tar.gz"
  sha256 "137e311a7489acd0107b28d9a42e1837b93f414185c6fc6424751e1e46107462"
  license "GPL-3.0-only"
  head "https://github.com/canonical/snapcraft.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "b8fab7ec65ef4a73408b4cab8579be1fbd7d1e0a5d9bee2ee4d80cfe253fb632"
    sha256 cellar: :any,                 arm64_sonoma:  "30e1ec6b17c3286ca2c8f7f9d45b552a2f388fc771efde1a269ee5e2eddd046c"
    sha256 cellar: :any,                 arm64_ventura: "e26ca318d8ec187a7ffa5d26ca3df8376653080dd7ff7e4702d2019b977b050d"
    sha256 cellar: :any,                 sonoma:        "ccbdf6171d73fac89f37a21b615a36f44d90f37008427ce983dc8735d7ce2b37"
    sha256 cellar: :any,                 ventura:       "25f7c0f8783ec8757cb2335bc6b753f8de3ed87ba31805db6ba2c64dd6ad865f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3dde5f8df3f052f33231bb5dff32af196fb8d344a34a4b7eed74823e602cf497"
  end

  depends_on "rust" => :build # for pydantic_core
  depends_on "libgit2@1.7"
  depends_on "libsodium"
  depends_on "libyaml"
  depends_on "lxc"
  depends_on "python@3.13"
  depends_on "snap"
  depends_on "xdelta"

  uses_from_macos "libffi"
  uses_from_macos "libxml2", since: :ventura
  uses_from_macos "libxslt"

  on_linux do
    depends_on "intltool" => :build # for python-distutils-extra
    depends_on "apt"
    depends_on "cryptography"

    # Extra non-PyPI Python resources
    # https://github.com/snapcore/snapcraft/blob/91a18b3128de4971edfc090a8683a64ff1679f2e/setup.py#L154-L158

    resource "python-distutils-extra" do
      url "https://ftp.debian.org/debian/pool/main/p/python-distutils-extra/python-distutils-extra_3.1.tar.xz"
      sha256 "f5972205e714989e5d648cced118260c1b94aec4ee52a5214546006842e053b9"
    end

    resource "python-apt" do
      url "https://ftp.debian.org/debian/pool/main/p/python-apt/python-apt_2.9.3.tar.xz"
      sha256 "8aeaae2c65a86031b9197ba65859d09aadd8e5f582a3a4333d7843c927ff1c99"
    end

    # Extra PyPI Python resources for Linux

    resource "jeepney" do
      url "https://files.pythonhosted.org/packages/d6/f4/154cf374c2daf2020e05c3c6a03c91348d59b23c5366e968feb198306fdf/jeepney-0.8.0.tar.gz"
      sha256 "5efe48d255973902f6badc3ce55e2aa6c5c3b3bc642059ef3a91247bcfcc5806"
    end

    resource "pylxd" do
      url "https://files.pythonhosted.org/packages/9b/8e/6a31a694560adaba20df521c3102bdecec06a0fea9c73ff1466834e2df30/pylxd-2.3.5.tar.gz"
      sha256 "d67973dd2dc1728e3e1b41cc973e11e6cbceae87878d193ac04cc2b65a7158ef"
    end

    resource "secretstorage" do
      url "https://files.pythonhosted.org/packages/53/a4/f48c9d79cb507ed1373477dbceaba7401fd8a23af63b837fa61f1dcd3691/SecretStorage-3.3.3.tar.gz"
      sha256 "2403533ef369eca6d2ba81718576c5e0f564d5cca1b58f73a8b23e7d4eeebd77"
    end

    resource "ws4py" do
      url "https://files.pythonhosted.org/packages/53/20/4019a739b2eefe9282d3822ef6a225250af964b117356971bd55e274193c/ws4py-0.5.1.tar.gz"
      sha256 "29d073d7f2e006373e6a848b1d00951a1107eb81f3742952be905429dc5a5483"
    end
  end

  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/ee/67/531ea369ba64dcff5ec9c3402f9f51bf748cec26dde048a2f973a4eea7f5/annotated_types-0.7.0.tar.gz"
    sha256 "aff07c09a53a08bc8cfccb9c85b05f1aa9a2a6f23728d790723543408344ce89"
  end

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/f6/40/318e58f669b1a9e00f5c4453910682e2d9dd594334539c7b7817dabb765f/anyio-4.7.0.tar.gz"
    sha256 "2f834749c602966b7d456a7567cafcb309f96482b5081d14ac93ccd457f9dd48"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/48/c8/6260f8ccc11f0917360fc0da435c5c9c7504e3db174d5a12a1494887b045/attrs-24.3.0.tar.gz"
    sha256 "8f5c07333d543103541ba7be0e2ce16eeee8130cb0b3f9238ab904ce1e85baff"
  end

  resource "boolean-py" do
    url "https://files.pythonhosted.org/packages/a2/d9/b6e56a303d221fc0bdff2c775e4eef7fedd58194aa5a96fa89fb71634cc9/boolean.py-4.0.tar.gz"
    sha256 "17b9a181630e43dde1851d42bef546d616d5d9b4480357514597e78b203d06e4"
  end

  resource "catkin-pkg" do
    url "https://files.pythonhosted.org/packages/2e/a2/88f8ba42a0119833887b8afe159f6e3ae96e2700720baf461eeabcc6acd8/catkin_pkg-1.0.0.tar.gz"
    sha256 "476e9f52917282f464739241b4bcaf5ebbfba9a7a68d9af8f875225feac0e1b5"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/b0/ee/9b19140fe824b367c04c5e1b369942dd754c4c5462d5674002f75c4dedc1/certifi-2024.8.30.tar.gz"
    sha256 "bec941d2aa8195e248a60b31ff9f0558284cf01a52591ceda73ea9afffd69fd9"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/fc/97/c783634659c2920c3fc70419e3af40972dbaf758daa229a7d6ea6135c90d/cffi-1.17.1.tar.gz"
    sha256 "1c39c6016c32bc48dd54561950ebd6836e1670f2ae46128f67cf49e789c52824"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/f3/0d/f7b6ab21ec75897ed80c17d79b15951a719226b9fababf1e40ea74d69079/chardet-5.2.0.tar.gz"
    sha256 "1b3b6ff479a8c414bc3fa2c0852995695c4a026dcd6d0633b2dd092ca39c1cf7"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/f2/4f/e1808dc01273379acc506d18f1504eb2d299bd4131743b9fc54d7be4df1e/charset_normalizer-3.4.0.tar.gz"
    sha256 "223217c3d4f82c3ac5e29032b3f1c2eb0fb591b72161f86d93f5719079dae93e"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "craft-application" do
    url "https://files.pythonhosted.org/packages/eb/e0/9d475fae0b4df40d3ca6caf4d0b3fe05a937a74aabb4aa5db3237c736dce/craft_application-4.6.0.tar.gz"
    sha256 "b1bac30a394267731ef320b526afa6a456620d7769582ef777fecaca92806508"
  end

  resource "craft-archives" do
    url "https://files.pythonhosted.org/packages/8b/8e/efd531838ceb591d4aaa4d032807131082bf20e39112472be33346cc9267/craft-archives-2.0.2.tar.gz"
    sha256 "8dfc0a78ba0bf1e63891975463e2a15c0028b9697b2282d6e9fe05bd6477960d"
  end

  resource "craft-cli" do
    url "https://files.pythonhosted.org/packages/9f/1f/cd622c8218adea214e11224f1dfa581242a307a023c9997f085ef0d9d1e0/craft_cli-2.13.0.tar.gz"
    sha256 "a53575dde5bc4284cba49573093eb940584ad3520aa989271345770e4f6f5172"
  end

  resource "craft-grammar" do
    url "https://files.pythonhosted.org/packages/02/d6/073514a6dd3f79fd82f73b0532df0f5dfc39c5ba548795a8c1406851e914/craft_grammar-2.0.1.tar.gz"
    sha256 "fd6d90b49f3dc1705d9a745192d61192f2eeb42ecb316d7a2b921083d7601c5a"
  end

  resource "craft-parts" do
    url "https://files.pythonhosted.org/packages/e6/d8/47a791e7a6403a1824f2031f24e61f4e29ea196a50cd6a276bd1f5f0f452/craft_parts-2.2.0.tar.gz"
    sha256 "4cc8dc3a79350fa7e96c0e0135001a1648cf8e2a9c236725a346236e62e82195"
  end

  resource "craft-platforms" do
    url "https://files.pythonhosted.org/packages/5c/bc/87096fac689bc25ee33ebf2d89e4cc48f39e59f6562a627f23ba2301e3b3/craft_platforms-0.4.0.tar.gz"
    sha256 "02e3c9064930660af24fb0c126c0d3ac73f6c9b28af0c96f18f4d3a6795b251b"
  end

  resource "craft-providers" do
    url "https://files.pythonhosted.org/packages/02/85/4c5a2cdafa858cfd10fe76fdab5fb0452e6dff895b12fe67c8cbe451685e/craft_providers-2.0.4.tar.gz"
    sha256 "a70248fb6705fc34f44f0d6a5af360945aca94f871bb607ef5c70de60652e776"
  end

  resource "craft-store" do
    url "https://files.pythonhosted.org/packages/1c/61/fcf3ba6904609d859e1fd6645de03c046d59d004a127a543e3fcd9d710d6/craft_store-3.1.0.tar.gz"
    sha256 "aaa5a88e4ae0da036ab0b630a90db25907f6cc22f2824f3a75c6a3498c00effb"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3/distro-1.9.0.tar.gz"
    sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/6b/5c/330ea8d383eb2ce973df34d1239b3b21e91cd8c865d21ff82902d952f91f/docutils-0.19.tar.gz"
    sha256 "33995a6753c30b7f577febfc2c50411fec6aac7f7ffeb7c4cfe5991072dcf9e6"
  end

  resource "gnupg" do
    url "https://files.pythonhosted.org/packages/96/6c/21f99b450d2f0821ff35343b9a7843b71e98de35192454606435c72991a8/gnupg-2.3.1.tar.gz"
    sha256 "8db5a05c369dbc231dab4c98515ce828f2dffdc14f1534441a6c59b71c6d2031"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/f5/38/3af3d3633a34a3316095b39c8e8fb4853a28a536e55d347bd8d8e9a14b03/h11-0.14.0.tar.gz"
    sha256 "8f19fbbe99e72420ff35c00b27a34cb9937e902a8b810e2c88300c6f0a3b699d"
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/6a/41/d7d0a89eb493922c37d343b607bc1b5da7f5be7e383740b4753ad8943e90/httpcore-1.0.7.tar.gz"
    sha256 "8551cb62a169ec7162ac7be8d4817d561f60e08eaa485234898414bb5a8a0b4c"
  end

  resource "httplib2" do
    url "https://files.pythonhosted.org/packages/3d/ad/2371116b22d616c194aa25ec410c9c6c37f23599dcd590502b74db197584/httplib2-0.22.0.tar.gz"
    sha256 "d7a10bc5ef5ab08322488bde8c726eeee5c8618723fdb399597ec58f3d82df81"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/10/df/676b7cf674dd1bdc71a64ad393c89879f75e4a0ab8395165b498262ae106/httpx-0.28.0.tar.gz"
    sha256 "0858d3bab51ba7e386637f22a61d8ccddaeec5f3fe4209da3a6168dbb91573e0"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f1/70/7703c29685631f5a7590aa73f1f1d3fa9a380e654b86af429e0934a32f7d/idna-3.10.tar.gz"
    sha256 "12f65c9b470abda6dc35cf8e63cc574b1c52b11df2c86030af0ac09b01b13ea9"
  end

  resource "jaraco-classes" do
    url "https://files.pythonhosted.org/packages/06/c0/ed4a27bc5571b99e3cff68f8a9fa5b56ff7df1c2251cc715a652ddd26402/jaraco.classes-3.4.0.tar.gz"
    sha256 "47a024b51d0239c0dd8c8540c6c7f484be3b8fcf0b2d85c13825780d3b3f3acd"
  end

  resource "jaraco-context" do
    url "https://files.pythonhosted.org/packages/df/ad/f3777b81bf0b6e7bc7514a1656d3e637b2e8e15fab2ce3235730b3e7a4e6/jaraco_context-6.0.1.tar.gz"
    sha256 "9bae4ea555cf0b14938dc0aee7c9f32ed303aa20a3b73e7dc80111628792d1b3"
  end

  resource "jaraco-functools" do
    url "https://files.pythonhosted.org/packages/ab/23/9894b3df5d0a6eb44611c36aec777823fc2e07740dabbd0b810e19594013/jaraco_functools-4.1.0.tar.gz"
    sha256 "70f7e0e2ae076498e212562325e805204fc092d7b4c17e0e86c959e249701a9d"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/ed/55/39036716d19cab0747a5020fc7e907f362fbf48c984b14e62127f7e68e5d/jinja2-3.1.4.tar.gz"
    sha256 "4a3aee7acbbe7303aede8e9648d13b8bf88a429282aa6122a993f0ac800cb369"
  end

  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/58/0d/c816f5ea5adaf1293a1d81d32e4cdfdaf8496973aa5049786d7fdb14e7e7/jsonschema-2.5.1.tar.gz"
    sha256 "36673ac378feed3daa5956276a829699056523d7961027911f064b52255ead41"
  end

  resource "keyring" do
    url "https://files.pythonhosted.org/packages/f6/24/64447b13df6a0e2797b586dad715766d756c932ce8ace7f67bd384d76ae0/keyring-25.5.0.tar.gz"
    sha256 "4c753b3ec91717fe713c4edd522d625889d8973a349b0e582622f49766de58e6"
  end

  resource "launchpadlib" do
    url "https://files.pythonhosted.org/packages/80/28/d1801b89af8f39e6b933840f0a2ab600fd502b67d04376d956297c36d7ef/launchpadlib-2.0.0.tar.gz"
    sha256 "5d4a9095e91773a7565d4c159594ae30eca792fd5f9b89ded459d711484a96cb"
  end

  resource "lazr-restfulclient" do
    url "https://files.pythonhosted.org/packages/ea/a3/45d80620a048c6f5d1acecbc244f00e65989914bca370a9179e3612aeec8/lazr.restfulclient-0.14.6.tar.gz"
    sha256 "43f12a1d3948463b1462038c47b429dcb5e42e0ba7f2e16511b02ba5d2adffdb"
  end

  resource "lazr-uri" do
    url "https://files.pythonhosted.org/packages/58/53/de9135d731a077b1b4a30672720870abdb62577f18b1f323c87e6e61b96c/lazr_uri-1.0.7.tar.gz"
    sha256 "ed0cf6f333e450114752afb1ce0c299c36ac4b109063eb50354c4f87f825a3ee"
  end

  resource "license-expression" do
    url "https://files.pythonhosted.org/packages/c7/97/df5570fe2f1046bb5f6eeed55815ef11e371e9310d53bd94ec8efe4173f4/license_expression-30.4.0.tar.gz"
    sha256 "6464397f8ed4353cc778999caec43b099f8d8d5b335f282e26a9eb9435522f05"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/e7/6b/20c3a4b24751377aaa6307eb230b66701024012c29dd374999cc92983269/lxml-5.3.0.tar.gz"
    sha256 "4e109ca30d1edec1ac60cdbe341905dc3b8f55b16855e03a54aaf59e51ec8c6f"
  end

  resource "macaroonbakery" do
    url "https://files.pythonhosted.org/packages/4b/ae/59f5ab870640bd43673b708e5f24aed592dc2673cc72caa49b0053b4af37/macaroonbakery-1.3.4.tar.gz"
    sha256 "41ca993a23e4f8ef2fe7723b5cd4a30c759735f1d5021e990770c8a0e0f33970"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/b2/97/5d42485e71dfc078108a86d6de8fa46db44a1a9295e89c5d6d4a06e23a62/markupsafe-3.0.2.tar.gz"
    sha256 "ee55d3edf80167e48ea11a923c7386f4669df67d7994554387f84e7d8b0a2bf0"
  end

  resource "more-itertools" do
    url "https://files.pythonhosted.org/packages/51/78/65922308c4248e0eb08ebcbe67c95d48615cc6f27854b6f2e57143e9178f/more-itertools-10.5.0.tar.gz"
    sha256 "5482bfef7849c25dc3c6dd53a6173ae4795da2a41a80faea6700d9f5846c5da6"
  end

  resource "mypy-extensions" do
    url "https://files.pythonhosted.org/packages/98/a4/1ab47638b92648243faf97a5aeb6ea83059cc3624972ab6b8d2316078d3f/mypy_extensions-1.0.0.tar.gz"
    sha256 "75dbf8955dc00442a438fc4d0666508a9a97b6bd41aa2f0ffe9d2f2725af0782"
  end

  resource "oauthlib" do
    url "https://files.pythonhosted.org/packages/6d/fa/fbf4001037904031639e6bfbfc02badfc7e12f137a8afa254df6c4c8a670/oauthlib-3.2.2.tar.gz"
    sha256 "9859c40929662bec5d64f34d01c99e093149682a3f38915dc0655d5a633dd918"
  end

  resource "overrides" do
    url "https://files.pythonhosted.org/packages/36/86/b585f53236dec60aba864e050778b25045f857e17f6e5ea0ae95fe80edd2/overrides-7.7.0.tar.gz"
    sha256 "55158fa3d93b98cc75299b1e67078ad9003ca27945c76162c1c0766d6f91820a"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/d0/63/68dbb6eb2de9cb10ee4c9c14a0148804425e13c4fb20d61cce69f53106da/packaging-24.2.tar.gz"
    sha256 "c228a6dc5e932d346bc5739379109d49e8853dd8223571c7c5b55260edc0b97f"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/13/fc/128cc9cb8f03208bdbf93d3aa862e16d376844a14f9a0ce5cf4507372de4/platformdirs-4.3.6.tar.gz"
    sha256 "357fb2acbc885b0419afd3ce3ed34564c13c9b95c89360cd9563f73aa5e2b907"
  end

  resource "progressbar" do
    url "https://files.pythonhosted.org/packages/a3/a6/b8e451f6cff1c99b4747a2f7235aa904d2d49e8e1464e0b798272aa84358/progressbar-2.5.tar.gz"
    sha256 "5d81cb529da2e223b53962afd6c8ca0f05c6670e40309a7219eacc36af9b6c63"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/d2/4f/1639b7b1633d8fd55f216ba01e21bf2c43384ab25ef3ddb35d85a52033e8/protobuf-5.29.1.tar.gz"
    sha256 "683be02ca21a6ffe80db6dd02c0b5b2892322c59ca57fd6c872d652cb80549cb"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/26/10/2a30b13c61e7cf937f4adf90710776b7918ed0a9c434e2c38224732af310/psutil-6.1.0.tar.gz"
    sha256 "353815f59a7f64cdaca1c0307ee13558a0512f6db064e92fe833784f08539c7a"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/1d/b2/31537cf4b1ca988837256c910a668b553fceb8f069bedc4b1c826024b52c/pycparser-2.22.tar.gz"
    sha256 "491c8be9c040f5390f5bf44a5b07752bd07f56edf992381b05c701439eec10f6"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/45/0f/27908242621b14e649a84e62b133de45f84c255eecb350ab02979844a788/pydantic-2.10.3.tar.gz"
    sha256 "cb5ac360ce894ceacd69c403187900a02c4b20b693a9dd1d643e1effab9eadf9"
  end

  resource "pydantic-core" do
    url "https://files.pythonhosted.org/packages/a6/9f/7de1f19b6aea45aeb441838782d68352e71bfa98ee6fa048d5041991b33e/pydantic_core-2.27.1.tar.gz"
    sha256 "62a763352879b84aa31058fc931884055fd75089cccbd9d58bb6afd01141b235"
  end

  resource "pyelftools" do
    url "https://files.pythonhosted.org/packages/88/56/0f2d69ed9a0060da009f672ddec8a71c041d098a66f6b1d80264bf6bbdc0/pyelftools-0.31.tar.gz"
    sha256 "c774416b10310156879443b81187d182d8d9ee499660380e645918b50bc88f99"
  end

  resource "pygit2" do
    url "https://files.pythonhosted.org/packages/09/50/f0795db653ceda94f4388d2b40598c188aa4990715909fabcf16b381b843/pygit2-1.13.3.tar.gz"
    sha256 "0257c626011e4afb99bdb20875443f706f84201d4c92637f02215b98eac13ded"
  end

  resource "pymacaroons" do
    url "https://files.pythonhosted.org/packages/37/b4/52ff00b59e91c4817ca60210c33caf11e85a7f68f7b361748ca2eb50923e/pymacaroons-0.13.0.tar.gz"
    sha256 "1e6bba42a5f66c245adf38a5a4006a99dcc06a0703786ea636098667d42903b8"
  end

  resource "pynacl" do
    url "https://files.pythonhosted.org/packages/a7/22/27582568be639dfe22ddb3902225f91f2f17ceff88ce80e4db396c8986da/PyNaCl-1.5.0.tar.gz"
    sha256 "8ac7448f09ab85811607bdd21ec2464495ac8b7c66d146bf545b0f08fb9220ba"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/8c/d5/e5aeee5387091148a19e1145f63606619cb5f20b83fccb63efae6474e7b2/pyparsing-3.2.0.tar.gz"
    sha256 "cbf74e27246d595d9a74b186b810f6fbb86726dbf3b9532efb343f6d7294fe9c"
  end

  resource "pyrfc3339" do
    url "https://files.pythonhosted.org/packages/00/52/75ea0ae249ba885c9429e421b4f94bc154df68484847f1ac164287d978d7/pyRFC3339-1.1.tar.gz"
    sha256 "81b8cbe1519cdb79bed04910dd6fa4e181faf8c88dff1e1b987b5f7ab23a5b1a"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
  end

  resource "python-debian" do
    url "https://files.pythonhosted.org/packages/ce/8d/2ebc549adf1f623d4044b108b30ff5cdac5756b0384cd9dddac63fe53eae/python-debian-0.1.49.tar.gz"
    sha256 "8cf677a30dbcb4be7a99536c17e11308a827a4d22028dc59a67f6c6dd3f0f58c"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/3a/31/3c70bf7603cc2dca0f19bdc53b4537a797747a58875b552c8c413d963a3f/pytz-2024.2.tar.gz"
    sha256 "2aa355083c50a0f93fa581709deac0c9ad65cca8a9e9beac660adcbd493c798a"
  end

  resource "pyxdg" do
    url "https://files.pythonhosted.org/packages/b0/25/7998cd2dec731acbd438fbf91bc619603fc5188de0a9a17699a781840452/pyxdg-0.28.tar.gz"
    sha256 "3267bb3074e934df202af2ee0868575484108581e6f3cb006af1da35395e88b4"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
    sha256 "d584d9ec91ad65861cc08d42e834324ef890a082e591037abe114850ff7bbc3e"
  end

  resource "raven" do
    url "https://files.pythonhosted.org/packages/79/57/b74a86d74f96b224a477316d418389af9738ba7a63c829477e7a86dd6f47/raven-6.10.0.tar.gz"
    sha256 "3fa6de6efa2493a7c827472e984ce9b020797d0da16f1db67197bcc23c8fae54"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "requests-toolbelt" do
    url "https://files.pythonhosted.org/packages/f3/61/d7545dafb7ac2230c70d38d31cbfe4cc64f7144dc41f6e4e4b78ecd9f5bb/requests-toolbelt-1.0.0.tar.gz"
    sha256 "7681a0a3d047012b5bdc0ee37d7f8f07ebe76ab08caeccfc3921ce23c88d5bc6"
  end

  resource "requests-unixsocket2" do
    url "https://files.pythonhosted.org/packages/14/66/88737c8720685f44e6a1c04cb2185301a6ec4538ac82324f0f33c9dc5fd5/requests_unixsocket2-0.4.2.tar.gz"
    sha256 "929c58ecc5981f3d127661ceb9ec8c76e0f08d31c52e44ab1462ac0dcd55b5f5"
  end

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/43/54/292f26c208734e9a7f067aea4a7e282c080750c4546559b58e2e45413ca0/setuptools-75.6.0.tar.gz"
    sha256 "8199222558df7c86216af4f84c30e9b34a61d8ba19366cc914424cdbd28252f6"
  end

  resource "simplejson" do
    url "https://files.pythonhosted.org/packages/3d/29/085111f19717f865eceaf0d4397bf3e76b08d60428b076b64e2a1903706d/simplejson-3.19.3.tar.gz"
    sha256 "8e086896c36210ab6050f2f9f095a5f1e03c83fa0e7f296d6cba425411364680"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end

  resource "snap-helpers" do
    url "https://files.pythonhosted.org/packages/50/2a/221ab0a9c0200065bdd8a5d2b131997e3e19ce81832fdf8138a7f5247216/snap-helpers-0.4.2.tar.gz"
    sha256 "ef3b8621e331bb71afe27e54ef742a7dd2edd9e8026afac285beb42109c8b9a9"
  end

  resource "tabulate" do
    url "https://files.pythonhosted.org/packages/ec/fe/802052aecb21e3797b8f7902564ab6ea0d60ff8ca23952079064155d1ae1/tabulate-0.9.0.tar.gz"
    sha256 "0095b12bf5966de529c0feb1fa08671671b3368eec77d7ef7ab114be2c068b3c"
  end

  resource "tinydb" do
    url "https://files.pythonhosted.org/packages/a0/79/4af51e2bb214b6ea58f857c51183d92beba85b23f7ba61c983ab3de56c33/tinydb-4.8.2.tar.gz"
    sha256 "f7dfc39b8d7fda7a1ca62a8dbb449ffd340a117c1206b68c50b1a481fb95181d"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/df/db/f35a00659bc03fec321ba8bce9420de607a1d37f8342eee1863174c69557/typing_extensions-4.12.2.tar.gz"
    sha256 "1a7ead55c7e559dd4dee8856e3a88b41225abfe1ce8df57b7c13915fe121ffb8"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/ed/63/22ba4ebfe7430b76388e7cd448d5478814d3032121827c12a2cc287e2260/urllib3-2.2.3.tar.gz"
    sha256 "e7d814a81dad81e6caf2ec9fdedb284ecc9c73076b62654547cc64ccdcae26e9"
  end

  resource "validators" do
    url "https://files.pythonhosted.org/packages/64/07/91582d69320f6f6daaf2d8072608a4ad8884683d4840e7e4f3a9dbdcc639/validators-0.34.0.tar.gz"
    sha256 "647fe407b45af9a74d245b943b18e6a816acf4926974278f6dd617778e1e781f"
  end

  resource "wadllib" do
    url "https://files.pythonhosted.org/packages/da/54/82866d8c2bf602ed9df52c8f8b7a45e94f8c2441b3d1e9e46d34f0e3270f/wadllib-2.0.0.tar.gz"
    sha256 "1edbaf23e4fa34fea70c9b380baa2a139b1086ae489ebcccc4b3b65fc9737427"
  end

  def install
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    ENV["SNAP_VERSION"] = version.to_s
    virtualenv_install_with_resources
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    assert_match version.to_s, shell_output("#{bin}/snapcraft --version")

    assert_match "Package, distribute, and update snaps", shell_output("#{bin}/snapcraft --help 2>&1")

    system bin/"snapcraft", "init"
    assert_predicate testpath/"snap/snapcraft.yaml", :exist?
  end
end
