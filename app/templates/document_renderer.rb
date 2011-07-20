#encoding: UTF-8
class DocumentRenderer < Renderer
  
  def render
    clause "Introduction" do
      para "My name is #{@name}."
    end
    clause "Synopsis" do
      para "This document, known as #{name}, seeks to explain that the name of the author is #{@name} and also to show things off for #{organisation}."
    end
    clause "Body" do
      subclause "arbitrary variable 1 goes here."
      subclause "arbitrary variable 2 goes here."
    end
  end
end
