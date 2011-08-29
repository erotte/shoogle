class Admin::FeetController < Admin::BaseController
  expose(:feet) do
    db.view(Foot.all)
  end
  expose(:foot) do
    db.load_document(params[:id])
  end

  def index
    respond_with feet
  end

  def destroy
    db.destroy_document foot
    flash[:message] = "Shoe #{params[:id]} destroyed."
  end
end
