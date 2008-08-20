module RedCloth::Formatters::HTML
  
  def gist(opts)
    txt = opts[:text]
    # if txt.match(/\d+/)
      "<script src=\"http://gist.github.com/#{opts[:text].to_i}.js\"></script>"
    # end
  end
  
end