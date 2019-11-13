class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:show, :edit, :update]

  def show
    authorize @workspace
  end

  def index
    # @workspaces = Workspace.all
    @workspace = policy_scope(Workspace).order(created_at: :asc)
    # workspace policy has scope.all , set the order of the workspaces
    authorize @workspace
  end

  def new
    @workspace = Workspace.new
    authorize @workspace
  end

  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.user = current_user
    authorize @workspace

    if @workspace.save
      redirect_to workspaces_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @workspace.update(workspace_params)
    redirect_to workspace_path(@workspace)
  end

  def destroy
    @workspace.destroy(workspace_params)
    redirect_to workspace_path(@workspace)
    authorize @workspace
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :address, :capacity, :photo, :photo_cache)
  end

  def set_workspace
    @workspace = Workspace.find(params[:id])
    authorize @workspace
  end
end
