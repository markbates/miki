module RedCloth::Formatters::HTML
  
  def gist(opts)
    txt = opts[:text]
    "<script src=\"http://gist.github.com/#{opts[:text].to_i}.js\"></script>"
  end
  
  def pre(opts)
    "<pre>#{opts[:text]}</pre>"
  end
  
end