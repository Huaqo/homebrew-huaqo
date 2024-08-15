
class Pdfc < Formula
  desc "PDF Compressor in C with Ghostscript"
  homepage "https://github.com/Huaqo/pdfc"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Huaqo/pdfc/releases/download/v1.0.0/pdfc-arm64"
    sha256 "4435d29be68665ec9d8e3cfe8ae072bcebbf064ec287fe9928383ee1ce9a9fbb"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Huaqo/pdfc/releases/download/v1.0.0/pdfc-x86_64"
    sha256 "49d59d93180d0a8268b0057c62c4c7653382400167cd0a2f8e2da65c05c89ffd"
  end
  
  license "MIT"

  depends_on "ghostscript"

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pdfc-arm64" => "pdfc"
    elsif OS.mac? && Hardware::CPU.intel?
      bin.install "pdfc-x86_64" => "pdfc"
    end
  end

  test do
    (testpath/"test.pdf").write <<~EOS
      %PDF-1.4
      %âãÏÓ
      1 0 obj
      << /Type /Catalog >>
      endobj
      xref
      0 1
      0000000000 65535 f
      trailer
      << /Size 1 /Root 1 0 R >>
      startxref
      9
      %%EOF
    EOS
    system bin/"pdfc", "test.pdf"
  end
end
