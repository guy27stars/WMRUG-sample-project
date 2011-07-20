class DocumentsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @document = Document.new
  end
  
  def index
    @user = User.find(params[:user_id])
  end
  
  def create
    new_document = current_user.documents.build
    params[:document].each do |key,value|
      new_document[key] = value
    end
    flash[:notice] = "document was created!" if new_document.save
    redirect_to users_path
  end
  
  def show
    document = current_user.documents.find(params[:id])
    pdf = Prawn::Document.new(:page_size => "A4")
    DocumentRenderer.new(pdf, document).render
    send_data pdf.render, :disposition => 'inline', :filename => "document.pdf", :type => "application/pdf"
  end
end
