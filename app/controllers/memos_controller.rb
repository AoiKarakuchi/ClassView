class MemosController < ApplicationController
    def create
        if current_user
            current_user.memos.create(content: memo_params["content"])
            redirect_to request.referer
        end
    end

    def destroy
        Memo.find(params[:id]).destroy
        redirect_to root_url, status: :see_other
    end

    private

    def memo_params
        params.require(:memo).permit(:content, :user_email, :id)
    end
end
