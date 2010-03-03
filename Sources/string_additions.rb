class String
  
  def lines_to_br
    self.gsub(/\n/, '<br />')
  end
  
  def odt_prevent_links
    self.gsub(/<a\s+href='([^']+)'\s*>/, "[a href='\\1']").gsub(/<\/\s*a\s*>/, "[/a]")
  end
  
  def odt_convert_links_back
    self.gsub(/\[a href='([^']+)'\]/, "<text:a xlink:type=\"simple\" xlink:href=\"\\1\">").gsub("[/a]", "</text:a>")
  end
  
end