class UploadsController < ApplicationController
  def create
    @file = Engineer.new( params.require(:engineer).permit(:last_name, :file) )
    @file.save
    redirect_to uploads_path
  end
end
