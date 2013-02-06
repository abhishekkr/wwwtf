class String

  def unescape
    string = self
    unescaped_string = ''
    escaped_at = string.index(/\\/)
    until escaped_at.nil?
      unescaped_string = "#{unescaped_string}#{string[0...escaped_at]}#{string[escaped_at + 1]}"
      string = string[(escaped_at + 2)..-1]
      escaped_at = string.index(/\\/)
    end
    "#{unescaped_string}#{string}"
  end
end
