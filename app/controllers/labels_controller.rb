class LabelsController < ApplicationController
  before_action :set_labels, only: %i[show edit update destroy]
  before_action :require_admin_user

  def index
    @labels = Label.all.page(params[:page])
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(labal_params)
    if @label.save
      redirect_to labels_path, success: "ラベル「#{@label.name}」を登録しました。"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @label.update(labal_params)
      redirect_to labels_path(@label), success: "ラベル「#{@label.name}」を更新しました"
    else
      flash.now[:danger] = "ラベルの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @label.destroy!
    redirect_to labels_path, danger: 'ラベルを削除しました'
  end

  private

  def set_labels
    @label = Label.find(params[:id])
  end

  def labal_params
    params.require(:label).permit(:name)
  end
end
