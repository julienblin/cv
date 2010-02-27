class String
  
  def lines_to_br
    self.gsub(/\n/, '<br />')
  end
  
end