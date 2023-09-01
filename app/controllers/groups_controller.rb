class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @groups = Group.where(user: @user)
  end

  def new
    @image_names = Dir.glob('app/assets/images/icons/*.png')
    @group = Group.new
    @user = current_user
  end

  def create
    @user = current_user
    @group = Group.new(group_params)
    @group.user_id = @user.id
    @image_names = Dir.glob('app/assets/images/icons/*.png')

    if @group.save
      flash[:notice] = 'Category created successfully'
      redirect_to user_groups_path(@user)
    else
      puts @group.errors.full_messages
      flash[:alert] = 'Something went wrong'
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = 'Category deleted successfully'
    redirect_to user_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
