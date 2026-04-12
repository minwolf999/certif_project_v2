# frozen_string_literal: true

RSpec.describe IconsHelper, type: :helper do
  describe "#svg_tag" do
    let(:svg_content) { '<svg viewBox="0 0 10 10"></svg>' }
    let(:file_path) do
      Rails.root.join('app', 'assets', 'images', 'svg', 'test.svg')
    end

    before do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return(svg_content)
    end

    it "returns nil if file does not exist" do
      allow(File).to receive(:exist?).and_return(false)

      expect(helper.svg_tag("missing")).to be_nil
    end

    it "adds default class when none provided" do
      result = helper.svg_tag("test")

      expect(result).to include('class="size-5"')
    end

    it "uses provided class" do
      result = helper.svg_tag("test", class: "w-6 h-6")

      expect(result).to include('class="w-6 h-6"')
    end

    it "injects class into svg tag" do
      result = helper.svg_tag("test")

      expect(result).to include('<svg class="size-5" viewBox=')
    end
  end
end
