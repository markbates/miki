module RedCloth::Formatters::HTML
  
  def gist(opts)
    txt = opts[:text]
    if txt.match(/http:\/\/gist.github.com\/\d+\.js/)
      "<script src=\"#{opts[:text]}\"></script>"
    end
  end
  
end