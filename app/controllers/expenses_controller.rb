class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @group = Group.includes(:expenses).find(params[:group_id])
    @expenses = @group.expenses.where(author: @user).order(created_at: :desc)
    @total_expense = @group.expenses.sum(:amount)
  end

  def new
    @user = current_user
    @group = Group.find(params[:group_id])
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.author = current_user
    @expense.group = Group.find(params[:group_id])

    if @expense.save
      flash[:notice] = 'Transaction successfully created'
      redirect_to user_group_expenses_path(current_user, @expense.group)
    else
      flash[:alert] = 'Something went wrong'
      redirect_to new_user_group_expense_path(current_user, @expense.group)
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    flash[:notice] = 'Transaction deleted successfully'
    redirect_to user_group_expenses_path
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :group_id)
  end
end
