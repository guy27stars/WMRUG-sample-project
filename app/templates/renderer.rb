class Renderer
  

  def method_missing(var)
    if @document[var] != nil
      return @document[var]
    else
      super
    end
  end

  def initialize(pdf, document)
    @pdf = pdf
    @clause_number = 1
    @document = document
    @name = @document.user.name
  end

  #This controls the creation of a numbered clause with a title.
  def clause(title, &block)
    #Restart the subclause letters.
    @subclause_letter = "a"
    #Group the entire clause so that it fits on one page.
    @pdf.group do
      #Insert clause title. Bolded and underlined by default.
      @pdf.text "<u>#{@clause_number}. #{title}</u>", :style => :bold, :size => 12, :inline_format => true
      #Insert the body of the clause, indented to the right slightly.
      @pdf.indent 10 do
        yield
      end #indent
    end #group
    #increment the clause number.
    @clause_number += 1
    #Add a gap before the next clause.
    @pdf.move_down 20
  end

  #This controls the creation of subclauses.
  def subclause(title, &block)
    @pdf.text "<b>(#{@subclause_letter})</b> #{title}", :inline_format => true
    @pdf.indent 15 do
      yield if block_given?
    end
    @subclause_letter.next!
  end
  
  def list(&block)
    @list_number = 1
    @pdf.indent 5 do
      yield
    end
  end
  
  def list_item(content)
    @pdf.text "<b>(#{convert @list_number})</b> " + content, :inline_format => true
    @list_number += 1
  end

  #This controls the creation of paragraphs of text.
  def para(content)
    @pdf.text content, :inline_format => true
  end

  def signature_line
    @pdf.float do
      @pdf.move_down 100
      @pdf.text "#{@name}"
    end
    random_signature
  end

  def render
  end

  #TODO: Take this out.
  def random_signature
    6.times do
      @pdf.stroke_curve [rand(050), @pdf.cursor - rand(100)], [rand(100), @pdf.cursor - rand(100)], :bounds => [[rand(20), @pdf.cursor - rand(120)], [rand(120), @pdf.cursor - rand(120)]]
    end
  end

end