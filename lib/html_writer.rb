class HtmlWriter
  VERSION = '0.1.0'
  
  VALID_TAGS = [:head, :title, :body, :p, :em, :strong]
  
  def initialize
    @html = ''
  end
  
  def write
    @html << '<html>'
    yield self
    @html << '</html>'
  end
  
  def doctype(doctype)
    case doctype
    when 5
      @html = '<!DOCTYPE html>' + @html
    end
  end
  
  def method_missing(name, *args, &block)
    super unless valid_tag?(name)
    @html << "<#{name}>"
    if block_given?
      yield self
    else
      @html << args.join('')
      args.join('')
    end
    @html << "</#{name}>"
  end
  
  private
  
  def valid_tag?(name)
    VALID_TAGS.include?(name.to_sym)
  end
end
