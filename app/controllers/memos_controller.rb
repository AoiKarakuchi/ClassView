class MemosController < ApplicationController
    def create 
        if current_user 
        current_user.memos.create(content:memo_params["content"]) 
        redirect_to request.referer 
        end 
    end 

    def destroy 
        if (memo=Memo.find(params["id"].to_i)) && (current_user.id == memo.user_email) 
            memo.destroy 
            flash[:success] = 'メモを削除しました' 
        else 
            flash[:danger] = 'メモの削除に失敗しました' 
        end 
        redirect_to request.referer 
    end 

    private 

    def memo_params 
        params.require(:memo).permit(:content,:user_email,:id) 
    end 
end