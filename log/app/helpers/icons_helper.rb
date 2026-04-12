# frozen_string_literal: true

module IconsHelper
  def svg_tag(name, options = {})
    file_path = Rails.root.join 'app', 'assets', 'images', 'svg', "#{name}.svg"
    return nil unless File.exist?(file_path)

    classes = []
    classes << options.delete(:class)
    classes << 'size-5' if classes.none?

    File.read(file_path).gsub(
      'viewBox=',
      "class=\"#{class_names(classes)}\" viewBox="
    ).strip.html_safe
  end
end
