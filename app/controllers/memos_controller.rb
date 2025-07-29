class MemosController < ApplicationController
    before_action :corrent_user, only: :destroy
    
    def create
        @memo = current_user.memos.build(memo_params)
        if @memo.save
          flash.now[:success] = "Memo created!"
          redirect_to root_url
        else
          flash.now[:danger] = "Memoを作成できませんでした"
          redirect_to root_url, status: :unprocessable_entity
        end
    end

    def destroy
        @memo.destroy
        flash.now[:success] = "Memo deleted"
        redirect_to root_url, status: :see_other
    end

    private

        def memo_params
            params.require(:memo).permit(:content)
        end

        def corrent_user
          @memo = current_user.memos.find_by(id: params[:id])
          redirect_to root_url, status: :see_other if @memo.nil?
        end
end
