class Document
  include Mongoid::Document
  embedded_in :user
  
  field :name
  field :organisation
  
end
